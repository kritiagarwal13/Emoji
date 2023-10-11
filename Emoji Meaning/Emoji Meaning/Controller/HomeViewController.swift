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
    private var viewModel : HomeViewModel!
    
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
    }
    
    
    //MARK: - Extra Methods
    
    func getCategories() {
        self.apiService.apiToGetCategoriesData { dataSet in
            self.categoryData = dataSet
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getEmojis() {
        self.apiService.apiToGetEmojiData { dataSet in
            self.emojiData = dataSet
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
