//
//  APIClient.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import Foundation

// MARK: - APIClient
struct APIClient<APIEndpoint: Endpoint> {
	func getData(from endpoint: APIEndpoint, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let request = performRequest(for: endpoint) else {
			completion(.failure(APIClientError.invalidURL))

			return
		}

		loadData(with: request) { result in
			switch result {
				case .success(let data):
					completion(.success(data))
				case .failure(let error):
					completion(.failure(error))
			}
		}
	}

	// MARK: - Request building
	private func performRequest(for endpoint: APIEndpoint) -> URLRequest? {
		guard var urlComponents = URLComponents(string: endpoint.absoluteURL) else {
			return nil
		}

		urlComponents.queryItems = endpoint.parameters.compactMap({ parameter -> URLQueryItem in
			return URLQueryItem(name: parameter.key, value: parameter.value)
		})

		guard let url = urlComponents.url else { return nil }

		let urlRequest = URLRequest(url: url,
									cachePolicy: .reloadRevalidatingCacheData,
									timeoutInterval: 15)

		return urlRequest
	}

	// MARK: - Getting data
	private func loadData(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data, error == nil else {
				guard let response = response as? HTTPURLResponse else {
					completion(.failure(APIClientError.dataNil))

					return
				}

				completion(.failure(APIError(rawValue: response.statusCode) ??
										APIClientError.unknownError))

				return
			}

			completion(.success(data))
		}

		task.resume()
	}
}
