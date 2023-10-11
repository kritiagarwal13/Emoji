////
////  HomeViewModel.swift
////  Emoji Meaning
////
////  Created by Kriti Agarwal on 10/10/23.
////
//
//import Foundation
//
//class HomeViewModel: NSObject {
//    
//    var getEmojis: (() -> ())?
//    var getCategories: (() -> ())?
//    
//    
//    override init() {
//        super.init()
//    }
//    
//    func requestEmojis() async throws -> [EmojiDataModel] {
//        let endpoint = "https://emoji-api.com/emojis?access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2"
//        guard let url = URL(string: endpoint) else {
//            throw GHError.invalidURL
//        }
//        let (data, response) = try await URLSession.shared.data(from:url)
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw GHError.invalidResponse
//        }
//        
//        do{
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode([EmojiDataModel].self, from: data)
//        } catch {
//            throw GHError.invalidData
//        }
//        
//        // Create the URL to fetch
//        guard let url = URL(string: "https://60c86ffcafc88600179f70e2.mockapi.io/api/getRequest") else { fatalError("Invalid URL") }
//
//        // Create the network manager
//        let apiService = APIService()
//
//        // Request data from the backend
//    apiService.request(fromURL: url) { (result: Result<[User], Error>) in
//            switch result {
//            case .success(let users):
//                debugPrint("We got a successful result with \(users.count) users.")
//            case .failure(let error):
//                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
//            }
//         }
//        
//        
//    }
//    
//    func requestCategories() async throws -> [CategoryDataModel] {
//        let endpoint = "https://emoji-api.com/categories?access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2"
//        guard let url = URL(string: endpoint) else {
//            throw GHError.invalidURL
//        }
//        let (data, response) = try await URLSession.shared.data(from:url)
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw GHError.invalidResponse
//        }
//        
//        do{
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode([CategoryDataModel].self, from: data)
//        } catch {
//            throw GHError.invalidData
//        }
//    }
//    
//}
