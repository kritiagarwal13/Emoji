//
//  ApiService.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 10/10/23.
//

import Foundation

class APIService :  NSObject {
   
    let path = "https://emoji-api.com"
    let privateAccessKey = "access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2"
    
    func fetchData<T: Decodable>(for type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let emptyDataError = NSError(domain: "YourErrorDomain", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                completion(.failure(emptyDataError))
            }
        }.resume()
    }
}
