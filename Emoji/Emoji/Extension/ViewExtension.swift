//
//  ViewExtension.swift
//  Emoji
//
//  Created by Kriti Agarwal on 18/11/23.
//

import Foundation
import UIKit

extension UIView {
    func addShadow() {
        layer.cornerRadius = 8.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 4.0
    }
}
