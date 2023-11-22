//
//  LodingSpinner.swift
//  Emoji
//
//  Created by Kriti Agarwal on 22/11/23.
//

import UIKit

class LoadingSpinner {
    static let shared = LoadingSpinner()

    private var spinner: UIActivityIndicatorView

    private init() {
        self.spinner = UIActivityIndicatorView(style: .large)
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.hidesWhenStopped = true
    }

    func addToView(_ view: UIView) {
        view.addSubview(self.spinner)
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func startAnimating() {
        self.spinner.startAnimating()
    }

    func stopAnimating() {
        self.spinner.stopAnimating()
    }
}
