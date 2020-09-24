//
//  Owner.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 24/09/20.
//

import Foundation

// MARK: - Owner
struct Owner {
	let login: String
	let avatarUrl: String
}

// MARK: - Decodable
extension Owner: Decodable {
	private enum OwnerKeys: String, CodingKey {
		case login
		case avatarUrl = "avatar_url"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: OwnerKeys.self)

		login = try container.decode(String.self, forKey: .login)
		avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
	}
}
