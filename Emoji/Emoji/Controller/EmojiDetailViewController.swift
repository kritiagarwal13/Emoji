//
//  EmojiDetailViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit

class EmojiDetailViewController: UIViewController {
   
    //MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var apiService = APIService()
//    var emojiData : EmojiDatasetModel?
    var emoji = ""
    var showSingleDetail = false
    var dataset = "SmileysDataset"
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        /*getEmojis*/()
    }
    
    //MARK: - Extra Methods
    
//    func getEmojis() {
//        if let path = Bundle.main.path(forResource: dataset, ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path))
//                let decoder = JSONDecoder()
//                let emojiData = try decoder.decode(EmojiDatasetModel.self, from: data)
//                self.emojiData = emojiData
//            } catch {
//                print("Error loading and parsing JSON: \(error)")
//            }
//        }
//        self.collectionView.reloadData()
//    }
}

//MARK: - Extensions

extension EmojiDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showSingleDetail {
            return 1
        } else {
            return  1//self.emojiData?.emojis.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiDetailCollectionViewCell", for: indexPath) as! EmojiDetailCollectionViewCell
//        if showSingleDetail {
//            for each in emojiData?.emojis ?? [] {
//                if self.emoji == each.emoji {
//                    cell.configureData(meaning: each.meaning, usage: each.usage.first?.context ?? "", example: each.usage.first?.example ?? "", title: each.name, emoji: each.emoji)
//                }
//            }
//        } else {
//            cell.configureData(meaning: self.emojiData?.emojis[indexPath.item].meaning ?? "", usage: self.emojiData?.emojis[indexPath.item].usage.first?.context ?? "", example: self.emojiData?.emojis[indexPath.item].usage.first?.example ?? "", title: self.emojiData?.emojis[indexPath.item].name ?? "", emoji: self.emojiData?.emojis[indexPath.item].emoji ?? "")
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width , height: self.collectionView.frame.height)
    }
    
}
