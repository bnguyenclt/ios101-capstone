//
//  String+CapitalizingFirstLetter.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/16/25.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
