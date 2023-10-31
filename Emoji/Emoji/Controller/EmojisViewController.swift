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
    var allEmojis = [EmojiCategory]()
    var emoji: EmojiInfo?
    var didTapSearch: Bool = false
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        for each in eData ?? [] {
            self.emojiData.append(contentsOf: each.emojiList)
        }
        for each in self.emojiData {
            if each.emoji == searchEmoji {
                self.emoji = each
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
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
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
            return 1
        } else {
            return self.emojiData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as! EmojiCollectionViewCell
        if self.didTapSearch {
            cell.configCellData(titleString: self.emoji?.emoji ?? "", fontHeight: CGFloat(100))
        } else {
            cell.configCellData(titleString: self.emojiData[indexPath.row].emoji, fontHeight: CGFloat(100))
        }
        
        cell.addShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  self.collectionView.frame.width/2 - 5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmojiDetailViewController") as! EmojiDetailViewController
        if self.didTapSearch {
            vc.emoji = self.emoji?.emoji ?? ""
            vc.emojiData = self.emoji
        } else {
            vc.emoji = self.emojiData[indexPath.row].emoji
            vc.emojiData = self.emojiData[indexPath.row]
        }
        vc.showSingleDetail = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            self.searchBar.resignFirstResponder()
        }
    }
    
}
