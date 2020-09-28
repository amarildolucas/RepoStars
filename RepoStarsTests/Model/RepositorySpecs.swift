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

		describe("The 'Repository'") {
			context("Given a valid JSON") {
				beforeEach {
					do {
						let loader = JSONLoader()
						sut = try loader.load()
					} catch {
						fail("Error while parsing JSON.")
					}
				}

				it("Then decode JSON successfully") {
					let repository = RepositorySample.repository

					expect(sut.items.count).to(equal(30))
					expect(sut.items.first!.name).to(equal(repository.name))
				}

				afterEach {
					sut = nil
				}
			}
		}
	}
}
