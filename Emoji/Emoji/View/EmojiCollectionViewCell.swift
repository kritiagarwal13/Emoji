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
    @IBOutlet weak var lblEmojiMeaning: UILabel!
    @IBOutlet weak var lblEmojiName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellData(emojiVal: EmojiInfo?, fontHeight: CGFloat) {
        self.lblTitle.font = UIFont.boldSystemFont(ofSize: fontHeight)
        self.lblTitle.text = emojiVal?.emoji
        self.lblEmojiName.text = emojiVal?.name
        self.lblEmojiMeaning.text = emojiVal?.meaning
    }
    
    func addShadow() {
        self.bgView.layer.cornerRadius = 8.0 // Adjust the corner radius as needed
        self.bgView.layer.masksToBounds = false
        self.bgView.layer.shadowColor = UIColor.lightGray.cgColor
        self.bgView.layer.shadowOffset = CGSize(width: 0, height: 2) // Adjust shadow offset as needed
        self.bgView.layer.shadowOpacity = 0.5 // Adjust shadow opacity as needed
        self.bgView.layer.shadowRadius = 4.0 // Adjust shadow radius as needed
        
        self.lblTitle.layer.cornerRadius = 8.0 // Adjust the corner radius as needed
        self.lblTitle.layer.masksToBounds = false
        self.lblTitle.layer.shadowColor = UIColor.lightGray.cgColor
        self.lblTitle.layer.shadowOffset = CGSize(width: 0, height: 2) // Adjust shadow offset as needed
        self.lblTitle.layer.shadowOpacity = 0.5 // Adjust shadow opacity as needed
        self.lblTitle.layer.shadowRadius = 4.0 // Adjust shadow radius as needed
    }
    
}
