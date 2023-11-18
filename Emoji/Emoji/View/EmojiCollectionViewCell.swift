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
    
    func addCellShadow() {
        self.bgView.addShadow()
        self.lblTitle.addShadow()
    }
    
}
