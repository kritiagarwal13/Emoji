//
//  EmojisViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class EmojisViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var emojiData = [EmojiInfo]()
    var searchedEmojis = [EmojiInfo]()
    var emoji: EmojiInfo?
    var vcTitle = "Emojis"
    var didTapSearch: Bool = false
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = vcTitle
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // API Call
        getEmojis()
    
    }
    
    //MARK: - Extra Methods
    
    func searchEmoji(searchEmojiText: String) {
        let reference = Database.database().reference()
        let validPath = "emojis"
        let dataReference = reference.child(validPath)
        
        dataReference.observe(.value) { (snapshot) in
            if snapshot.exists(), let data = snapshot.value as? [[String: Any]] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decodedData = try JSONDecoder().decode([EmojiCategory].self, from: jsonData)
                    self.searchedEmoji(eData: decodedData, searchEmoji: searchEmojiText)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
    }
    
    func searchedEmoji(eData: [EmojiCategory]?, searchEmoji: String) {
        // Clear the previous search results
        searchedEmojis.removeAll()
        
        // Flatten the emojiData array
        let flatEmojiData = eData?.flatMap { $0.emojiList } ?? []
        
        for emoji in flatEmojiData {
            // Perform a case-insensitive search for both emoji and name
            if emoji.emoji.range(of: searchEmoji, options: .caseInsensitive) != nil ||
                emoji.name.range(of: searchEmoji, options: .caseInsensitive) != nil {
                searchedEmojis.append(emoji)
            }
        }
    }
    
    
    func getEmojis() {
        let reference = Database.database().reference()
        let validPath = "emojis"
        let dataReference = reference.child(validPath)
        
        dataReference.observe(.value) { (snapshot) in
            if snapshot.exists(), let data = snapshot.value as? [[String: Any]] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decodedData = try JSONDecoder().decode([EmojiCategory].self, from: jsonData)
                    self.structureData(allEmojis: decodedData)
                    } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
    }
    
    func structureData(allEmojis: [EmojiCategory]?) {
        for each in allEmojis ?? [] {
            self.emojiData.append(contentsOf: each.emojiList)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

//MARK: - Extensions
extension EmojisViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            self.didTapSearch = false
            self.emoji = nil
            self.emojiData = []
            self.searchedEmojis = []
            self.getEmojis()
        } else {
            self.didTapSearch = true
            self.searchEmoji(searchEmojiText: searchText)
        }
    }
    
    
}

extension EmojisViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.didTapSearch {
            return self.searchedEmojis.count
        } else {
            return self.emojiData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as! EmojiCollectionViewCell
        if self.didTapSearch {
            cell.configCellData(emojiVal: self.searchedEmojis[indexPath.row], fontHeight: CGFloat(100))
        } else {
            cell.configCellData(emojiVal: self.emojiData[indexPath.row], fontHeight: CGFloat(100))
        }
        
        cell.addCellShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  self.collectionView.frame.width - 10
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmojiDetailViewController") as! EmojiDetailViewController
        if self.didTapSearch {
            vc.emoji = self.searchedEmojis[indexPath.row].emoji 
            vc.emojiData = self.searchedEmojis[indexPath.row]
        } else {
            vc.emoji = self.emojiData[indexPath.row].emoji
            vc.emojiData = self.emojiData[indexPath.row]
        }
        vc.showSingleDetail = true
        
        let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("myCustomDetent")) { [weak self] context in
                guard let self = self else { return 0.0 }
                return self.view.frame.height - 200.0
            }
            
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [ customDetent ]
            }

            present(vc, animated: true)
    }
    
}
