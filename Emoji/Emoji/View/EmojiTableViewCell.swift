//
//  EmojiTableViewCell.swift
//  Emoji
//
//  Created by Kriti Agarwal on 21/11/23.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEmojiImage: UILabel!
    @IBOutlet weak var lblEmojiTitle: UILabel!
    @IBOutlet weak var lblEmojiMeaning: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configCellData(emojiVal: EmojiInfo?, fontHeight: CGFloat) {
        self.lblEmojiImage.font = UIFont.boldSystemFont(ofSize: fontHeight)
        self.lblEmojiImage.text = emojiVal?.emoji
        self.lblEmojiTitle.text = emojiVal?.name
        self.lblEmojiMeaning.text = emojiVal?.meaning
    }
    
}
