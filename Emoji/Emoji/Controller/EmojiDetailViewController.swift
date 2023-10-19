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
        let fileName = "Data/ActivityDataset"

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                // Read the JSON file as Data
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                // Parse the JSON data
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // You now have an array of dictionaries (JSON objects)
                    for item in jsonArray {
                        // Access data from each JSON object
                        if let value = item["key"] as? String {
                            print("Value from JSON: \(value)")
                        }
                    }
                }
            } catch {
                print("Error reading or parsing the JSON file: \(error)")
            }
        } else {
            print("did not find the file")
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
