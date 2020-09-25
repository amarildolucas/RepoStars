//
//  RepoStarsAsyncTests.swift
//  RepoStarsAsyncTests
//
//  Created by Amarildo Lucas on 23/09/20.
//

import Nimble
import Quick

@testable import RepoStars

// MARK: - RepositorySpecs
class RepositorySpecs: QuickSpec {
	override func spec() {
		var sut: Repositories!

		describe("A 'Repository'") {
			context("Given a valid JSON") {
				beforeEach {
					let bundle = Bundle(for: type(of: self))
					if let path = bundle.path(forResource: "Repositories",
											  ofType: "json") {
						do {
							let data = try Data(contentsOf: URL(fileURLWithPath: path),
												options: .alwaysMapped)
							let decoder = JSONDecoder()
							sut = try decoder.decode(Repositories.self, from: data)
						} catch {
							fail("Error while parsing JSON.")
						}
					}

					it("Then decode JSON successfully") {
						let owner = Owner(login: "vsouza",
										  avatarUrl: "https://avatars2.githubusercontent.com/u/484656?v=4")
						let firstRepository = Repository(name: "awesome-ios",
														 stargazersCount: 35715,
														 owner: owner)

						expect(sut.items.count).to(equal(30))
						expect(sut.items.first!.name).to(equal(firstRepository.name))
					}
				}

				afterEach {
					sut = nil
				}
			}
		}
	}
}
