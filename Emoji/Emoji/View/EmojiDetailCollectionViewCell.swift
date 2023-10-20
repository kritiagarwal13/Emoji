//
//  EmojiDetailCollectionViewCell.swift
//  Emoji Meaning
//
//  Created by Kriti Agarwal on 19/10/23.
//

import UIKit

class EmojiDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var upperVw: UIView!
    @IBOutlet weak var belowVw: UIView!
    @IBOutlet weak var emojiLbl: UILabel!
    @IBOutlet weak var lblMeaning: UILabel!
    @IBOutlet weak var lblUsage: UILabel!
    @IBOutlet weak var lblExample: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpUI() {
        self.belowVw.layer.cornerRadius = 20
        self.belowVw.layer.shadowColor = UIColor.gray.cgColor
        self.belowVw.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.belowVw.layer.shadowRadius = 20
    }
    
    func configureData(meaning: String, usage: String, example: String, title: String, emoji: String) {
        setUpUI()
        self.lblMeaning.text = meaning
        self.lblUsage.text = usage
        self.lblExample.text = example
        self.lblTitle.text = title
        self.emojiLbl.text = emoji
    }
    
}
