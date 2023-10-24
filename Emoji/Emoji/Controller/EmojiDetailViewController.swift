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
    var emojiData : EmojiInfo?
    var emojiDataset : EmojiCategory?
    var showSingleDetail = false
    var emoji = ""
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        /*getEmojis*/()
    }
    
    //MARK: - Extra Methods

}

//MARK: - Extensions

extension EmojiDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showSingleDetail {
            return 1
        } else {
            return self.emojiDataset?.emojisList.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiDetailCollectionViewCell", for: indexPath) as! EmojiDetailCollectionViewCell
        if showSingleDetail {
            cell.configureData(meaning: emojiData?.meaning ?? "", usage: emojiData?.usage.first?.context ?? "", example: emojiData?.usage.first?.example ?? "", title: emojiData?.name ?? "", emoji: emojiData?.emoji ?? "")
        } else {
            cell.configureData(meaning: emojiDataset?.emojisList[indexPath.item].meaning ?? "", usage: emojiDataset?.emojisList[indexPath.item].usage.first?.context ?? "", example: emojiDataset?.emojisList[indexPath.item].usage.first?.example ?? "", title: emojiDataset?.emojisList[indexPath.item].name ?? "", emoji: emojiDataset?.emojisList[indexPath.item].emoji ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width , height: self.collectionView.frame.height)
    }
    
}
