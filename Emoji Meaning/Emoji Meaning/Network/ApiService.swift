//
//  ApiService.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 10/10/23.
//

import Foundation

class APIService :  NSObject {
    
    private let emojisDataSourcesURL = URL(string: "https://emoji-api.com/emojis?access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2")!
    private let categoriesDataSourcesURL = URL(string: "https://emoji-api.com/categories?access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2")!
    
    func apiToGetEmojiData(completion : @escaping ([EmojiDataModel]) -> ()){
        URLSession.shared.dataTask(with: emojisDataSourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let emojiData = try! jsonDecoder.decode([EmojiDataModel].self, from: data)
                    completion(emojiData)
            }
        }.resume()
    }
    
    func apiToGetCategoriesData(completion : @escaping ([CategoryDataModel]) -> ()){
        URLSession.shared.dataTask(with: categoriesDataSourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let categoryData = try! jsonDecoder.decode([CategoryDataModel].self, from: data)
                    completion(categoryData)
            }
        }.resume()
    }
}
