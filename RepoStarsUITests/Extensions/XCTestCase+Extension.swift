//
//  XCTestCase+Extension.swift
//  RepoStarsUITests
//
//  Created by Amarildo Lucas on 29/09/20.
//

import KIF
import XCTest

// MARK: - XCTestCase+Extension
extension XCTestCase {
	func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
		return KIFUITestActor(inFile: file, atLine: line, delegate: self)
	}

	func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
		return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
	}
}
