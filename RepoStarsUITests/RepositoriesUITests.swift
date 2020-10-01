//
//  RepoStarsUITests.swift
//  RepoStarsUITests
//
//  Created by Amarildo Lucas on 29/09/20.
//

import KIF

// MARK: - RepositoriesUITest
class RepositoriesUITests: KIFTestCase {
	func testListRepositories_WithCorrectUI() {
		tester().waitForView(withAccessibilityLabel: "Activity Indicator")
		tester().usingTimeout(30).waitForView(withAccessibilityLabel: "Repositories Table")
		tester().waitForTappableView(withAccessibilityLabel: "Repository Table Cell")
		tester().waitForView(withAccessibilityLabel: "Avatar Image")
		tester().waitForView(withAccessibilityLabel: "Owner Name")
		tester().waitForView(withAccessibilityLabel: "Repository Name")
		tester().waitForView(withAccessibilityLabel: "Stars")
	}

	func testListRepositories_WithPullToRefresh() {
		tester().usingTimeout(30).pullToRefreshView(withAccessibilityLabel: "Repositories Table",
								   pullDownDuration: .inAboutAHalfSecond)
		tester().usingTimeout(30).waitForView(withAccessibilityLabel: "Repositories Table")
		tester().waitForTappableView(withAccessibilityLabel: "Repository Table Cell")
		tester().waitForView(withAccessibilityLabel: "Avatar Image")
		tester().waitForView(withAccessibilityLabel: "Owner Name")
		tester().waitForView(withAccessibilityLabel: "Repository Name")
		tester().waitForView(withAccessibilityLabel: "Stars")
	}
}
