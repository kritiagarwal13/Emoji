//
//  HomeViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 05/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var categoryData: [CategoryDataModel]?
    var emojiData: [EmojiDataModel]?
    var apiService = APIService()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // API Call
        getCategories()
        
    }
    
    //MARK: - @IBActions
    @IBAction func segmentControlDidTap(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            getCategories()
        } else {
            getEmojis()
        }
        self.collectionView.reloadData()
    }
    
    
    //MARK: - Extra Methods
    
    func getCategories() {
        let urlString = NetworkParams.path.rawValue + UrlEndpoint.categories.rawValue + apiService.privateAccessKey
        self.apiService.fetchData(for: [CategoryDataModel].self, from: URL(string: urlString)!) { result in
            switch result {
            case .success(let categoryData):
                // Handle emojiData
                self.categoryData = categoryData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                // Handle error
                print(error.localizedDescription)
            }
        }
    }
    
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.segmentControl.selectedSegmentIndex == 0 {
            return self.categoryData?.count ?? 1
        } else {
            return self.emojiData?.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        if self.segmentControl.selectedSegmentIndex == 0 {
            cell.configCellData(titleString: self.categoryData?[indexPath.row].slug ?? "", fontHeight: CGFloat(18))
        } else {
            cell.configCellData(titleString: self.emojiData?[indexPath.row].character ?? "", fontHeight: CGFloat(100))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  self.collectionView.frame.width/2 - 10
        return CGSize(width: width, height: width)
    }
    
}
