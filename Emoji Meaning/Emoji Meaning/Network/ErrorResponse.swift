//
//  ErrorResponse.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 10/10/23.
//

import Foundation

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

enum HttpMethod: String {
    case get
    case post
    
    var method: String { rawValue.uppercased() }
}

enum UrlEndpoint: String {
    case emojis = "/emojis"
    case categories = "/categories"
}

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: Wrapped
}
