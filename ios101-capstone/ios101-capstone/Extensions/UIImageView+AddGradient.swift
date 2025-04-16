//
//  UIView+AddGradient.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/16/25.
//

import UIKit

extension UIImageView {
    // For insert layer in Foreground
    func addGradientLayerInForeground(colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colors.map{$0.cgColor}
        
        self.layer.addSublayer(gradient)
    }
}
