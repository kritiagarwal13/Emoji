//
//  EmojiCollectionViewCell.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellData(titleString: String, fontHeight: CGFloat) {
        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.shadowColor = UIColor.lightGray.cgColor
        self.bgView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.bgView.layer.shadowRadius = 5
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: fontHeight)
        self.lblTitle.text = titleString
    }
    
}
