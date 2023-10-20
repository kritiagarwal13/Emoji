//
//  CategoriesViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit

class CategoriesViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var categoryData: [CategoryDataModel]?
    var apiService = APIService()
    var titleArr = ["😀", "👥", "🐶", "🍽️","🧘🏻‍♂️",  "🚉", "⏰", "♻️", "🏳️"]
    var categoryArr = ["SmileysDataset", "People-Dataset", "Animal-and-NatureDataset", "Food-and-DrinkDataset","ActivityDataset", "Travel-and-PlacesDataset", "ObjectsDataset", "SymbolsDataset", "FlagsDataset"]
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // API Call
        getCategories()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.getCategories()
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

}

//MARK: - Extensions

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArr.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.configCellData(titleString: self.titleArr[indexPath.row], fontHeight: CGFloat(100))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width/2 - 5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmojiDetailViewController") as! EmojiDetailViewController
        vc.dataset = self.categoryArr[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
