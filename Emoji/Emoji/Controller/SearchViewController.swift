//
//  SearchViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 08/10/23.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Properties
    var emojiData = [EmojiInfo]()
    var emoji: EmojiInfo?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //MARK: - @IBActions
    
    
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
                    print(decodedData.count)
                    for each in decodedData {
                        self.emojiData.append(contentsOf: each.emojisList)
                    }
                    for each in self.emojiData {
                        if each.emoji == searchEmojiText {
                            self.emoji = each
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
    }
}

    //MARK: - Extensions
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchEmoji(searchEmojiText: searchText)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((self.emoji?.usage.isEmpty) != nil) {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as! EmojiCollectionViewCell
        cell.configCellData(titleString: self.emoji?.emoji ?? "", fontHeight: CGFloat(100))
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
        vc.emojiData = self.emoji
        vc.showSingleDetail = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
