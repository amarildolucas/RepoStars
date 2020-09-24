//
//  Repository.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 24/09/20.
//

import Foundation

// MARK: - Repository
struct Repository {
	let name: String
	let stargazersCount: Int
	let owner: Owner
}

// MARK: - Decodable
extension Repository: Decodable {
	private enum RepositoryKeys: String, CodingKey {
		case name
		case stargazersCount = "stargazers_count"
		case owner
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RepositoryKeys.self)

		name = try container.decode(String.self, forKey: .name)
		stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
		owner = try container.decode(Owner.self, forKey: .owner)
	}
}
