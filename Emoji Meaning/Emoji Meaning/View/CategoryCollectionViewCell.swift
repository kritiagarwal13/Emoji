//
//  CategoryCollectionViewCell.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 10/10/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCellData(titleString: String) {
        self.lblTitle.text = titleString
    }
}
