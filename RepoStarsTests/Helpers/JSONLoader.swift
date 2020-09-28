//
//  JSONLoader.swift
//  RepoStarsTests
//
//  Created by Amarildo Lucas on 28/09/20.
//

import Foundation

@testable import RepoStars

// MARK: - JSONLoader
class JSONLoader {
	func load() throws -> Repositories {
		let bundle = Bundle(for: type(of: self))

		let path = bundle.path(forResource: "Repositories", ofType: "json")!
		do {
			let data = try Data(contentsOf: URL(fileURLWithPath: path),
								options: .alwaysMapped)
			let decoder = JSONDecoder()

			return try decoder.decode(Repositories.self, from: data)
		} catch {
			throw error
		}
	}
}
