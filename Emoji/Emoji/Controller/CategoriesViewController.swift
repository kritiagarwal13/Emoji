//
//  CategoriesViewController.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class CategoriesViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var emojiCategoryData : [EmojiCategory]?
    var selectedCategory: [EmojiInfo]?
    var selectedIndexPath : IndexPath?
    let spinner = LoadingSpinner.shared
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        collectionViewSetup()
        tableViewSetup()
        setupUI()
        
        // API Call
        getCategoryData()
        
        // Set the default selected index path
        selectedIndexPath = IndexPath(item: 0, section: 0)
        selectDefaultCell()
    }
    
    //MARK: - Extra Methods
    
    func setupUI() {
        spinner.addToView(self.view)
    }
    
    func collectionViewSetup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func tableViewSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "EmojiTableViewCell", bundle: nil), forCellReuseIdentifier: "EmojiTableViewCell")
    }
    
    func selectDefaultCell() {
        // Ensure there is at least one section and one item in the collection view
        guard self.collectionView.numberOfSections > 0, self.collectionView.numberOfItems(inSection: 0) > 0 else {
            return
        }
        
        // Select the first cell
        self.selectedIndexPath = IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        self.collectionView(self.collectionView, didSelectItemAt: self.selectedIndexPath ?? IndexPath(item: 0, section: 0))
    }
    
    func getCategoryData() {
        self.spinner.startAnimating()
        let reference = Database.database().reference()
        let validPath = "emojis"
        let dataReference = reference.child(validPath)
        
        dataReference.observe(.value) { (snapshot) in
            if snapshot.exists(), let data = snapshot.value as? [[String: Any]] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decodedData = try JSONDecoder().decode([EmojiCategory].self, from: jsonData)
                    self.emojiCategoryData = decodedData
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.selectedCategory = self.emojiCategoryData?.first?.emojiList ?? []
                        self.tableView.reloadData()
                    }
                    self.spinner.stopAnimating()
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
    }
    
}

//MARK: - Extensions

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.emojiCategoryData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.configCellData(titleString: self.emojiCategoryData?[indexPath.row].smiley ?? "")
        cell.bgView.addShadow()
        
        // Check if the current cell is selected
        if indexPath == selectedIndexPath {
            cell.bgView.backgroundColor = #colorLiteral(red: 0.2020092309, green: 0.6003368497, blue: 0.3991933763, alpha: 1)
        } else {
            cell.bgView.backgroundColor = UIColor.systemBackground
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width/2 - 20
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the previously selected cell
        if let selectedIndexPath = selectedIndexPath,
           let cell = collectionView.cellForItem(at: selectedIndexPath) as? CategoryCollectionViewCell {
            cell.bgView.backgroundColor = UIColor.systemBackground
        }
        
        // Select the new cell
        selectedCategory = emojiCategoryData?[indexPath.item].emojiList ?? []
        selectedIndexPath = indexPath
        
        // Update the selected cell's appearance
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            cell.bgView.backgroundColor = #colorLiteral(red: 0.2020092309, green: 0.6003368497, blue: 0.3991933763, alpha: 1)
        }
        
        tableView.reloadData()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedCategory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiTableViewCell", for: indexPath) as! EmojiTableViewCell
        cell.configCellData(emojiVal: self.selectedCategory?[indexPath.row], fontHeight: 100)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EmojiDetailViewController") as! EmojiDetailViewController
        vc.emoji = self.selectedCategory?[indexPath.row].emoji ?? ""
        vc.emojiData = self.selectedCategory?[indexPath.row]
        vc.showSingleDetail = true
        
        let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("myCustomDetent")) { [weak self] context in
            guard let self = self else { return 0.0 }
            return self.view.frame.height - 180.0
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [ customDetent ]
        }
        
        present(vc, animated: true)
    }
}
