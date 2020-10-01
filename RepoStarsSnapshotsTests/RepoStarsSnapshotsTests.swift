//
//  RepoStarsSnapshots.swift
//  RepoStarsSnapshots
//
//  Created by Amarildo Lucas on 30/09/20.
//

import Nimble
import Nimble_Snapshots
import Quick

@testable import RepoStars

// MARK: - RepoStarsSnapshotsTests
class RepoStarsSnapshotsTests: QuickSpec {
	override func spec() {
		describe("The 'RepositoriesViewController'") {
			var sut: RepositoriesViewController!

			context("Record Snapshots") {
				beforeEach {
					let presenter = RepositoriesPresenter()
					sut = RepositoriesViewController(presenter: presenter)
					presenter.delegate = sut
				}

				it("Should have correct repositories UITableView with data") {
					let view = sut.view
					sut.presenter.searchRepositories(query: "swift:language",
													 sort: "stars",
													 page: 1)

//					expect(view).toEventually(recordSnapshot(), timeout: 40)
					expect(view).to(haveValidSnapshot())
				}

				afterEach {
					sut = nil
				}
			}
		}
	}
}
