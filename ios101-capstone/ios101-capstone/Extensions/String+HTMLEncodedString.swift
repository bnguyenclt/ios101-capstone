//
//  String+HTMLEncodedString.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/14/25.
//

import Foundation

extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: String.Encoding.utf16, allowLossyConversion: true) else { return nil }
        
        guard let attributedString      = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ) else { return nil }
        
        self.init(attributedString.string)
    }
}
