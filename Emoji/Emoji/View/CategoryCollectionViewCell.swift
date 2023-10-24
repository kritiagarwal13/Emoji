//
//  CategoryCollectionViewCell.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 10/10/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var bgView: UIView!
        
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCellData(titleString: String, fontHeight: CGFloat) {
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: fontHeight)
        self.lblTitle.text = titleString
    }
    
    func addShadow() {
        self.bgView.layer.cornerRadius = 8.0 // Adjust the corner radius as needed
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.shadowColor = UIColor.lightGray.cgColor
        self.bgView.layer.shadowOffset = CGSize(width: 0, height: 2) // Adjust shadow offset as needed
        self.bgView.layer.shadowOpacity = 0.5 // Adjust shadow opacity as needed
        self.bgView.layer.shadowRadius = 4.0 // Adjust shadow radius as needed
    }
}
