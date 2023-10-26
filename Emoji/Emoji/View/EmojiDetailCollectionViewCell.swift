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
    @IBOutlet weak var tableView: UITableView!
    
    var emojiDisplayData: EmojiInfo?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addShadow() {
        self.emojiLbl.layer.cornerRadius = 20
        self.emojiLbl.layer.shadowColor = UIColor.gray.cgColor
        self.emojiLbl.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.emojiLbl.layer.shadowRadius = 20
        self.belowVw.layer.cornerRadius = 20
        self.belowVw.layer.shadowColor = UIColor.gray.cgColor
        self.belowVw.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.belowVw.layer.shadowRadius = 20
    }
    
    func configureData(emojiData: EmojiInfo?) {
        self.emojiDisplayData = emojiData
        self.lblTitle.text = emojiData?.name
        self.emojiLbl.text = emojiData?.emoji
        self.tableView.reloadData()
    }
    
}

extension EmojiDetailCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiDisplayDataTableViewCell", for: indexPath) as! EmojiDisplayDataTableViewCell
        if indexPath.row == 0 {
            cell.configureData(heading: "Meaning", value: self.emojiDisplayData?.meaning ?? "")
        } else if indexPath.row == 1 {
            cell.configureData(heading: "Usage Context", value: self.emojiDisplayData?.usage.first?.context ?? "")
        } else {
            cell.configureData(heading: "Usage Example", value: self.emojiDisplayData?.usage.first?.example ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

class EmojiDisplayDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureData(heading: String, value: String) {
        self.lblHeading.text = heading
        self.lblValue.text = value
    }
    
}
