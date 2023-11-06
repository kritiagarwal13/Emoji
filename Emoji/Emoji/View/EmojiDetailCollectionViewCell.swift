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
        self.lblTitle.layer.cornerRadius = 8.0
        self.lblTitle.layer.masksToBounds = false
        self.lblTitle.layer.shadowColor = UIColor.clear.cgColor
        self.lblTitle.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.lblTitle.layer.shadowOpacity = 0.5
        self.lblTitle.layer.shadowRadius = 4.0
        
        self.emojiLbl.layer.cornerRadius = 8.0
        self.emojiLbl.layer.masksToBounds = false
        self.emojiLbl.layer.shadowColor = UIColor.darkGray.cgColor
        self.emojiLbl.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.emojiLbl.layer.shadowOpacity = 0.5
        self.emojiLbl.layer.shadowRadius = 4.0
        
        self.belowVw.layer.cornerRadius = 8.0
        self.belowVw.layer.masksToBounds = false
        self.belowVw.layer.shadowColor = UIColor.lightGray.cgColor
        self.belowVw.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.belowVw.layer.shadowOpacity = 0.5
        self.belowVw.layer.shadowRadius = 4.0
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
        if self.emojiDisplayData?.usage.count ?? 0 > 1 {
            return 5
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiDisplayDataTableViewCell", for: indexPath) as! EmojiDisplayDataTableViewCell
        
        if self.emojiDisplayData?.usage.count ?? 0 > 1 {
            if indexPath.row == 3 {
                cell.configureData(heading: "Usage", value: "Context - " +  (self.emojiDisplayData?.usage.last?.context ?? ""))
            } else if indexPath.row == 4 {
                cell.configureData(heading: "Example", value: self.emojiDisplayData?.usage.last?.example ?? "")
            }
        }
        if indexPath.row == 0 {
            cell.configureData(heading: "Meaning", value: self.emojiDisplayData?.meaning ?? "")
        } else if indexPath.row == 1 {
            cell.configureData(heading: "Usage", value: "Context - " + (self.emojiDisplayData?.usage.first?.context ?? ""))
        } else if indexPath.row == 2 {
            cell.configureData(heading: "Example", value: self.emojiDisplayData?.usage.first?.example ?? "")
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
