//
//  APIError.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 23/09/20.
//

import Foundation

// MARK: - APIError
enum APIError: Int, LocalizedError {
	case badRequest = 400
	case unAuthorized = 401
	case tooManyRequests = 429
	case serverError = 500

	var errorDescription: String? {
		switch self {
			case .badRequest:
				return "Solicitação mal formatada."
			case .unAuthorized:
				return "Não autorizado"
			case .tooManyRequests:
				return "Você passou do limite de requests. Aguarde um momento e volte a tentar."
			case .serverError:
				return "Erro do servidor."
		}
	}
}
