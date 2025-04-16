//
//  CustomButton.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/12/25.
//

import UIKit

class CustomButton: UIButton {
    
    // Override init.
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") } // Init for Storyboard.
    
    // Initialization with background color and title parameters.
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
    }
    
}
