//
//  APIClientError.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import Foundation

// MARK: - APIClientError
enum APIClientError: LocalizedError {
	case invalidURL
	case dataNil
	case decodingError
	case unknownError

	var errorDescription: String? {
		switch self {
			case .invalidURL:
				return "URL inválida."
			case .dataNil:
				return "Não foi possível recuperar nenhum dado."
			case .decodingError:
				return "Dados estão no formato inválido."
			default:
				return "Algo deu errado."
		}
	}
}
