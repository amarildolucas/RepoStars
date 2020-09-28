//
//  RepositoriesPresenterSpecs.swift
//  RepoStarsTests
//
//  Created by Amarildo Lucas on 25/09/20.
//

import Nimble
import Quick

@testable import RepoStars

// MARK: - RepositoriesPresenterSpecs
class RepositoriesPresenterSpecs: QuickSpec {
	override func spec() {
		var sut: RepositoriesPresenter!

		describe("The 'RepositoriesPresenter'") {
			beforeEach {
				sut = RepositoriesPresenter()

				do {
					let loader = JSONLoader()
					sut.repositories = try loader.load().items
				} catch {
					fail("Error while parsing JSON.")
				}
			}

			context("When given Repositories") {
				it("Should return the number of repositories") {
					expect(sut.numberOfRepositories).to(equal(30))
				}

				it("Should return a repository in a row") {
					let repositoryInRow = sut.repositoryForRow(0)
					let repository = RepositorySample.repository

					expect(repositoryInRow.name).to(contain(repository.name))
					expect(repositoryInRow.stargazersCount).to(equal(repository.stargazersCount))
					expect(repositoryInRow.owner.login).to(contain(repository.owner.login))
					expect(repositoryInRow.owner.avatarUrl).to(contain(repository.owner.avatarUrl))
				}
			}

			context("When given RepositoriesViewController") {
				it("Set title") {
					let viewController = RepositoriesViewController(presenter: sut)

					sut.delegate = viewController
					sut.setTitle()

					let title = viewController.title

					expect("🔍 Swift").to(equal(title))
				}
			}

			afterEach {
				sut = nil
			}
		}
	}
}
