//
//  NetworkParams.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 12/10/23.
//

import Foundation

enum NetworkParams: String {
    case path = "https://emoji-api.com"
    case privateAccessKey = "access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2"
}

enum UrlEndpoint: String {
    case emojis = "/emojis?"
    case categories = "/categories?"
}

enum HttpMethod: String {
    case get
    case post
    
    var method: String { rawValue.uppercased() }
}
