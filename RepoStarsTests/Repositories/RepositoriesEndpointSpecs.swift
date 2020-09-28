//
//  RepositoriesEndpointSpecs.swift
//  RepoStarsTests
//
//  Created by Amarildo Lucas on 28/09/20.
//

import Nimble
import Quick

@testable import RepoStars

// MARK: - RepositoriesEndpointSpecs
class RepositoriesEndpointSpecs: QuickSpec {
	override func spec() {
		var sut: RepositoriesEndpoint!

		describe("The 'RepositoriesEndpoint'") {
			context("When given an 'Enpoint'") {
				beforeEach {
					sut = .searchRepositories(query: "swift:language",
											  sort: "stars",
											  page: 1)
				}

				it("have a base URL") {
					expect(sut.baseURL).to(equal("https://api.github.com"))
				}

				it("have an absolute URL") {
					expect(sut.absoluteURL).to(equal("https://api.github.com/search/repositories"))
				}

				it("have parameters") {
					let parameters =  ["q": "swift:language",
									   "sort": "stars",
									   "page": String(1)]

					expect(sut.parameters).to(equal(parameters))
				}

				afterEach {
					sut = nil
				}
			}
		}
	}
}
