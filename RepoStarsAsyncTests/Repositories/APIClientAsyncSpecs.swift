//
//  APIClientAsyncSpecs.swift
//  RepoStarsAsyncTests
//
//  Created by Amarildo Lucas on 28/09/20.
//

import Nimble
import Quick

@testable import RepoStars

// MARK: - APIClientAsyncSpecs
class APIClientAsyncSpecs: QuickSpec {
	override func spec() {
		var sut: APIClient<RepositoriesEndpoint>!

		describe("The 'APIClient' for 'RepositoriesEndpoint'") {
			context("Given a request to API") {
				beforeEach {
					sut = APIClient<RepositoriesEndpoint>()
				}

				it("GET data") {
					let endpoint: RepositoriesEndpoint = .searchRepositories(
						query: "swift:language",
						sort: "stars",
						page: 1)

					waitUntil(timeout: 15) { done in
						sut.getData(from: endpoint) { result in
							switch result {
								case .success(let data):
									expect(data).toNot(beNil())

									done()
								case .failure(let error):
									fail(error.localizedDescription)
							}
						}
					}
				}

				afterEach {
					sut = nil
				}
			}
		}
	}
}
