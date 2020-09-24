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
		tableView.isHidden = true
		tableView.backgroundColor = .systemBackground
		tableView.allowsSelection = false
		tableView.dataSource = self
		tableView.rowHeight = 120
		tableView.addSubview(refreshControl)
		tableView.register(RepositoryTableCell.self,
						   forCellReuseIdentifier: String(describing: RepositoryTableCell.self))

		return tableView
	}()

	lazy var refreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.attributedTitle = NSAttributedString(string: "🔎 pesquisando...")
		control.addTarget(self, action: #selector(refreshRepositories), for: .valueChanged)

		return control
	}()

	lazy var activityIndicatorView: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.tintColor = .label
		view.color = .label
		view.hidesWhenStopped = true
		view.isHidden = true

		return view
	}()

	lazy var messageLabel: UILabel = {
		let label = UILabel()
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
		presenter.searchRepositories(query: query, sort: sort)
	}

	@objc private func refreshRepositories() {
		presenter.searchRepositories(query: query, sort: sort)
	}
}

// MARK: - Layout
extension RepositoriesViewController {
	private func layoutViews() {
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
		cell.configure(with: repository)

		return cell
	}
}
