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
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    //MARK: - @IBActions
    @IBAction func segmentControlDidTap(_ sender: UISegmentedControl) {
        
    }
    
    
    //MARK: - Extra Methods

}

//MARK: - Extensions

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  self.collectionView.frame.width/2 - 10
        return CGSize(width: width, height: width)
    }
    
}
