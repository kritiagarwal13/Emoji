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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func configCellData(titleString: String) {
        self.lblTitle.text = titleString
    }
}
