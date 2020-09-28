//
//  RepositoriesViewModel.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 24/09/20.
//

import Foundation

// MARK: - RepositoriesPresenterDelegate
protocol RepositoriesPresenterDelegate: class {
	func didStartLoading()
	func didSetTitle(_ title: String)
	func repositoriesDidLoad(_ repositories: [Repository])
	func repositoriesDidLoad(with messageError: String)
	func didFinishLoading()
}

// MARK: - RepositoriesPresenter
class RepositoriesPresenter {
	weak var delegate: RepositoriesPresenterDelegate?
	let apiClient = APIClient<RepositoriesEndpoint>()

	var repositories: [Repository] = []

	var numberOfRepositories: Int {
		return repositories.count
	}

	func repositoryForRow(_ row: Int) -> Repository {
		return repositories[row]
	}

	func setTitle() {
		delegate?.didSetTitle("🔍 Swift")
	}
}

// MARK: - API Client methods
extension RepositoriesPresenter {
	func searchRepositories(query: String, sort: String, page: Int) {
		delegate?.didStartLoading()

		apiClient.getData(from: .searchRepositories(query: query,
													sort: sort,
													page: page)) { [weak self] result in
			DispatchQueue.main.async {
				self?.delegate?.didFinishLoading()
			}

			switch result {
				case .success(let data):
					let decoder = JSONDecoder()

					do {
						let repositories = try decoder.decode(Repositories.self, from: data)

						DispatchQueue.main.async {
							let items = repositories.items
							self?.repositories = items
							self?.delegate?.repositoriesDidLoad(items)
						}
					} catch {
						DispatchQueue.main.async {
							self?.delegate?.repositoriesDidLoad(with: APIClientError.decodingError.localizedDescription)
						}
					}
				case .failure(let error):
					DispatchQueue.main.async {
						self?.delegate?.repositoriesDidLoad(with: error.localizedDescription)
					}
			}
		}
	}
}
