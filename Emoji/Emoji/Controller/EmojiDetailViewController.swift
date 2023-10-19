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
    var emoji = ""
    var emojiTitle = ""
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        getEmojis()
    }
    
    //MARK: - Extra Methods
    
    func getEmojis() {
        if let fileURL = Bundle.main.url(forResource: "ActivityDataset", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: mockJSON, options: .prettyPrinted)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    print(jsonString ?? "Could not convert to JSON string")
                } catch {
                    print("Error converting to JSON: \(error)")
                }
            } catch {
                print("error")
            }
        } else {
            print("JSON file not found")
        }
    }

}

//MARK: - Extensions

extension EmojiDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiDetailCollectionViewCell", for: indexPath) as! EmojiDetailCollectionViewCell
        cell.emojiLbl.text = self.emoji
        cell.lblTitle.text = self.emojiTitle
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
}
