//
//  WaterfallDataCell.swift
//  ios101-capstone
//
//  Modified by Benjamin Nguyen on 4/13/2025.
//  Original file credit to Vebjørn Daniloff: https://github.com/vebbis321/WaterfallCompostionalLayout
//  Package credit to Evgenii Shishko: https://github.com/eeshishko/WaterfallTrueCompositionalLayout
//

import UIKit
import Apollo
import AniListAPI

class WaterfallDataCell: UICollectionViewCell {
    static let reuseIdentifier = "WaterfallDataCell"
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }()
    
    var id: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
   
    func setUpLayout() {
        contentView.addSubview(imageView)
        imageView.addSubview(indexLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        indexLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        indexLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        indexLabel.text = nil
    }
    
    func set(media: PaginationQuery.Data.Page.Medium) {
        DispatchQueue.main.async {
            self.indexLabel.text = media.title?.romaji
            self.imageView.downloaded(from: (media.coverImage?.extraLarge)!, contentMode: .scaleAspectFill)
            self.id = media.id
        }
    }
    
}





