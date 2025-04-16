//
//  CustomLabel.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/13/25.
//

import UIKit

class CustomLabel: UILabel {
    
    // Override init.
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") } // Init for Storyboard.
    
    // Initialization with title parameters.
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        configure()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
        self.numberOfLines = 0
    }

}
