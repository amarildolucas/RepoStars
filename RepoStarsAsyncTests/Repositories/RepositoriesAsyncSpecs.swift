//
//  RepoStarsAsyncTests.swift
//  RepoStarsAsyncTests
//
//  Created by Amarildo Lucas on 28/09/20.
//

import Nimble
import Quick

@testable import RepoStars

// MARK: - RepoStarsAsyncTests
class RepositoriesAsyncSpecs: QuickSpec {
	override func spec() {
		var sut: RepositoriesPresenter!

		describe("The 'RepositoriesPresenter'") {
			context("When given a 'query', 'sort' and 'page' parameters") {
				beforeEach {
					sut = RepositoriesPresenter()
				}

				it("'GET' request from API") {
					waitUntil { done in
						sut.searchRepositories(query: "language:swift",
											   sort: "stars",
											   page: 1)

//						expect(sut.numberOfRepositories).to(beGreaterThan(0))
//						expect(sut.repositoryForRow(0)).notTo(beNil())

						done()
					}
				}

				afterEach {
					sut = nil
				}
			}
		}
	}
}
