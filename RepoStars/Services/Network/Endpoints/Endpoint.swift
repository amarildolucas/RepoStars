//
//  EndpointProtocol.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import Foundation

// MARK: - Endpoint
protocol Endpoint {
	var baseURL: String { get }
	var absoluteURL: String { get }
	var parameters: [String: String] { get }
}
