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
		tester().waitForView(withAccessibilityLabel: "Repositories Table")
		tester().waitForTappableView(withAccessibilityLabel: "Repository Table Cell")
		tester().waitForView(withAccessibilityLabel: "Avatar Image")
		tester().waitForView(withAccessibilityLabel: "Owner Name")
		tester().waitForView(withAccessibilityLabel: "Repository Name")
		tester().waitForView(withAccessibilityLabel: "Stars")
	}

	func testListRepositories_WithPullToRefresh() {
		tester().pullToRefreshView(withAccessibilityLabel: "Refresh Control",
								   pullDownDuration: .inAboutAHalfSecond)
		tester().waitForView(withAccessibilityLabel: "Repositories Table")
		tester().waitForTappableView(withAccessibilityLabel: "Repository Table Cell")
		tester().waitForView(withAccessibilityLabel: "Avatar Image")
		tester().waitForView(withAccessibilityLabel: "Owner Name")
		tester().waitForView(withAccessibilityLabel: "Repository Name")
		tester().waitForView(withAccessibilityLabel: "Stars")
		tester().accessibilityScroll(.down)
	}
}
