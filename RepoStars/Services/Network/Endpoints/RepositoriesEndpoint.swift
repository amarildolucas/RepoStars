//
//  RepositoriesEndpoint.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import Foundation

// MARK: - RepositoriesEndpoint
enum RepositoriesEndpoint: Endpoint {
	case searchRepositories(query: String, sort: String)

	var baseURL: String {
		return "https://api.github.com"
	}

	var absoluteURL: String {
		switch self {
			case .searchRepositories:
				return baseURL + "/search/repositories"
		}
	}

	var parameters: [String : String] {
		switch self {
			case .searchRepositories(let query, let sorted):
				return ["q": query, "sort": sorted]
		}
	}
}
