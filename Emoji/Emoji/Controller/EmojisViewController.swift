//
//  EmojisViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit

class EmojisViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var emojiData: [EmojiDataModel]?
    var apiService = APIService()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        self.collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "EmojiCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // API Call
        getEmojis()
    }
    
    //MARK: - Extra Methods
    
    func getEmojis() {
        let urlString = NetworkParams.path.rawValue + UrlEndpoint.emojis.rawValue + apiService.privateAccessKey
        self.apiService.fetchData(for: [EmojiDataModel].self, from: URL(string: urlString)!) { result in
            switch result {
            case .success(let emojiData):
                // Handle emojiData
                self.emojiData = emojiData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                // Handle error
                print(error.localizedDescription)
            }
        }
    }

}

//MARK: - Extensions

extension EmojisViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.emojiData?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as! EmojiCollectionViewCell
        cell.configCellData(titleString: self.emojiData?[indexPath.row].character ?? "", fontHeight: CGFloat(100))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  self.collectionView.frame.width/2 - 5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmojiDetailViewController") as! EmojiDetailViewController
        vc.emoji = self.emojiData?[indexPath.row].character ?? ""
        vc.emojiTitle = self.emojiData?[indexPath.row].unicodeName ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
