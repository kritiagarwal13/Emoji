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
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // API Call
        Task {
            do {
                self.categoryData = try await getCategories()
            } catch GHError.invalidURL{
                print("invalidURL")
            } catch GHError.invalidData{
                print("invalidData")
            } catch GHError.invalidResponse{
                print("invalidResponse")
            } catch {
                print("unexpected error")
            }
            self.collectionView.reloadData()
        }
        
    }
    
    //MARK: - @IBActions
    @IBAction func segmentControlDidTap(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            Task {
                do {
                    self.categoryData = try await getCategories()
                } catch GHError.invalidURL{
                    print("invalidURL")
                } catch GHError.invalidData{
                    print("invalidData")
                } catch GHError.invalidResponse{
                    print("invalidResponse")
                } catch {
                    print("unexpected error")
                }
                self.collectionView.reloadData()
            }
        } else {
            Task {
                do {
                    self.emojiData = try await getEmojis()
                } catch GHError.invalidURL{
                    print("invalidURL")
                } catch GHError.invalidData{
                    print("invalidData")
                } catch GHError.invalidResponse{
                    print("invalidResponse")
                } catch {
                    print("unexpected error")
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    
    //MARK: - Extra Methods
    func getCategories() async throws -> [CategoryDataModel] {
        let endpoint = "https://emoji-api.com/categories?access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from:url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([CategoryDataModel].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getEmojis() async throws -> [EmojiDataModel] {
        let endpoint = "https://emoji-api.com/emojis?access_key=3abee5a084b4391501f4ee86b7e9f2de2383f2a2"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from:url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([EmojiDataModel].self, from: data)
        } catch {
            throw GHError.invalidData
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
