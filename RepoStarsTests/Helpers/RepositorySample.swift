//
//  RepositorySample.swift
//  RepoStarsTests
//
//  Created by Amarildo Lucas on 28/09/20.
//

import Foundation

@testable import RepoStars

// MARK: - RepositorySample
struct RepositorySample {
	static var repository: Repository {
		let owner = Owner(login: "vsouza",
						  avatarUrl: "https://avatars2.githubusercontent.com/u/484656?v=4")
		let repository = Repository(name: "awesome-ios",
									stargazersCount: 35715,
									owner: owner)

		return repository
	}
}
