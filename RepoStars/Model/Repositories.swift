//
//  Repositories.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 24/09/20.
//

import Foundation

// MARK: - Repositories
struct Repositories {
	let totalCount: Int
	let incompleteResults: Bool
	let items: [Repository]
}

// MARK: - Decodable
extension Repositories: Decodable {
	private enum RepositoryKeys: String, CodingKey {
		case totalCount = "total_count"
		case incompleteResults = "incomplete_results"
		case items
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RepositoryKeys.self)

		totalCount = try container.decode(Int.self, forKey: .totalCount)
		incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
		items = try container.decode([Repository].self, forKey: .items)
	}
}
