//
//  EmojiDataModel.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 10/10/23.
//

import Foundation

struct EmojiDataModel: Codable {
    /*{
    "slug": "grinning-face",
    "character": "\ud83d\ude00",
    "unicodeName": "grinning face",
    "codePoint": "1F600",
    "group": "smileys-emotion",
    "subGroup": "face-smiling"
    } */
    
    let slug: String
    let character: String
    let unicodeName: String
    let codePoint: String
    let group: String
    let subGroup: String
    
}


struct CategoryDataModel: Codable {
    /* {
     "slug": "smileys-emotion",
     "subCategories": [
     "face-smiling",
     "face-affection",
     "face-tongue",
     "face-hand",
     "face-neutral-skeptical",
     "face-sleepy",
     "face-unwell",
     "face-hat",
     "face-glasses",
     "face-concerned",
     "face-negative",
     "face-costume",
     "cat-face",
     "monkey-face",
     "emotion"
     ]
     }*/
    
    let slug: String
    let subCategories: [String]
}

struct EmojiModel: Codable {
    let emoji: String
    let name: String
    let meaning: String
    let usage: [UsageModel]
}

struct UsageModel: Codable {
    let context: String
    let example: String
}

struct EmojiDatasetModel: Codable {
    let emojis: [EmojiModel]
}

/*"emojis": [
    {
        "emoji": "😀",
        "name": "Grinning Face",
        "meaning": "A classic grinning face, indicating happiness or a friendly greeting.",
        "usage": [
            {
                "context": "Messaging",
                "example": "I'm so excited to see you! 😀"
            },
            {
                "context": "Social Media",
                "example": "Greeting friends with a big 😀."
            }
        ]
    }
*/
