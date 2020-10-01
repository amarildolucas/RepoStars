//
//  ViewController.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import UIKit

// MARK: - RepositoriesViewController
class RepositoriesViewController: UIViewController {
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.accessibilityLabel = "Repositories Table"
		tableView.isHidden = true
		tableView.backgroundColor = .systemBackground
		tableView.allowsSelection = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = 120
		tableView.addSubview(refreshControl)
		tableView.register(RepositoryTableCell.self,
						   forCellReuseIdentifier: String(describing: RepositoryTableCell.self))

		return tableView
	}()

	lazy var refreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.accessibilityLabel = "Refresh Control"
		control.attributedTitle = NSAttributedString(string: "🔎 pesquisando...")
		control.addTarget(self, action: #selector(refreshRepositories), for: .valueChanged)

		return control
	}()

	lazy var activityIndicatorView: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.accessibilityLabel = "Activity Indicator"
		view.tintColor = .label
		view.color = .label
		view.hidesWhenStopped = true
		view.isHidden = true

		return view
	}()

	lazy var messageLabel: UILabel = {
		let label = UILabel()
		label.accessibilityLabel = "Repositories Message"
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = .label
		label.textAlignment = .center
		label.numberOfLines = 0
		label.isHidden = true

		return label
	}()

	#warning("The fields should be passed on a UI company. But for the challenge purpouse they are passed as contants here.")
	private let query: String = "language:swift"
	private let sort: String = "stars"
	private var page: Int = 1

	private var loadsMoreData: Bool = false
	private var isLoading: Bool = false

	let presenter: RepositoriesPresenter

	init(presenter: RepositoriesPresenter) {
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - RepositoriesPresenterDelegate
extension RepositoriesViewController: RepositoriesPresenterDelegate {
	func didStartLoading() {
		activityIndicatorView.isHidden = false
		activityIndicatorView.startAnimating()
	}

	func didSetTitle(_ title: String) {
		self.title = title
	}

	func repositoriesDidLoad(_ repositories: [Repository]) {
		isLoading = false
		loadsMoreData = true

		messageLabel.isHidden = true
		tableView.isHidden = false
		tableView.reloadData()
	}

	func repositoriesDidLoad(with messageError: String) {
		tableView.isHidden = true
		messageLabel.isHidden = false
		messageLabel.text = messageError
	}

	func didFinishLoading() {
		activityIndicatorView.stopAnimating()
		refreshControl.endRefreshing()
	}
}

// MARK: - Lifecycle
extension RepositoriesViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		layoutViews()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)

		presenter.delegate = self
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)

		presenter.setTitle()
		refreshRepositories()
	}

	@objc private func refreshRepositories() {
		presenter.removeAllRepositories()

		tableView.reloadData()
		tableView.isHidden = true

		page = 1
		presenter.searchRepositories(query: query, sort: sort, page: page)
		page += 1
	}

	private func loadMoreData(at row: Int) {
		if !isLoading && loadsMoreData && row == presenter.lastRowIndex {
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
				guard !self.presenter.isLastRepository else { return }

				self.presenter.searchRepositories(query: self.query,
												  sort: self.sort,
												  page: self.page)
				self.page += 1
				self.isLoading = true
			}
		}
	}
}

// MARK: - Layout
extension RepositoriesViewController {
	private func layoutViews() {
		let reloadBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gobackward"),
												  style: .plain,
												  target: self,
												  action: #selector(refreshRepositories))
		navigationItem.rightBarButtonItem = reloadBarButtonItem

		view.backgroundColor = .systemBackground

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		view.insertSubview(activityIndicatorView, aboveSubview: tableView)
		activityIndicatorView.snp.makeConstraints { make in
			make.width.height.equalTo(32.0)
			make.centerX.centerY.equalToSuperview()
		}

		view.addSubview(messageLabel)
		messageLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16.0)
			make.trailing.equalToSuperview().offset(-16.0)
			make.centerY.equalToSuperview()
		}
	}
}

// MARK: - UITableViewDataSource
extension RepositoriesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.numberOfRepositories
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let repository = presenter.repositoryForRow(indexPath.row)

		let cell = tableView.dequeueReusableCell(
			withIdentifier: String(describing: RepositoryTableCell.self),
			for: indexPath) as! RepositoryTableCell
		cell.accessibilityLabel = "Repository Table Cell"
		cell.tag = indexPath.row
		cell.configure(with: repository, at: indexPath.row)

		return cell
	}
}

// MARK: - UITableViewDelegate
extension RepositoriesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		loadMoreData(at: indexPath.row)
	}
}

