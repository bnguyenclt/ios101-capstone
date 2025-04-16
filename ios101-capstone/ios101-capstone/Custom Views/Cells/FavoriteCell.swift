//
//  FavoritesCell.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/16/25.
//

import UIKit
import AniListAPI

class FavoriteCell: UITableViewCell {
    
    static let reuseIdentifier = "FavoriteCell"
    
    let mediaImage      = UIImageView()
    
    let detailStackView = UIStackView()
    let romajiTitle     = CustomLabel()
    let japaneseTitle   = CustomLabel()
    let seasonYearLabel = CustomLabel()
    
    var id: Int     = 0
    let rowHeight: CGFloat  = 100
    let padding: CGFloat    = 5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureStackView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        addSubview(mediaImage)
        
        self.backgroundColor = .clear
        
        mediaImage.translatesAutoresizingMaskIntoConstraints = false
        mediaImage.clipsToBounds = true
        mediaImage.layer.cornerRadius = 2
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: rowHeight),
            
            mediaImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mediaImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            mediaImage.heightAnchor.constraint(equalToConstant: rowHeight - padding),
            mediaImage.widthAnchor.constraint(equalToConstant: rowHeight - padding),
        ])
    }
    
    func configureStackView() {
        addSubview(detailStackView)
        
        detailStackView.addArrangedSubview(romajiTitle)
        detailStackView.addArrangedSubview(japaneseTitle)
        detailStackView.addArrangedSubview(seasonYearLabel)
        
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.isLayoutMarginsRelativeArrangement        = false
        detailStackView.layoutMargins                             = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        detailStackView.axis      = .vertical
        detailStackView.alignment = .leading
        
        romajiTitle.font = romajiTitle.font.withSize(24)
        
        japaneseTitle.font = japaneseTitle.font.withSize(14)
        
        seasonYearLabel.font = seasonYearLabel.font.withSize(14)
        
        NSLayoutConstraint.activate([
            detailStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            detailStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            detailStackView.leadingAnchor.constraint(equalTo: mediaImage.trailingAnchor, constant: padding * 3),
            detailStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding * 3),
        ])
    }
    
    func set(for id: Int) {
        NetworkManager.shared.getMediaWithinCache(for: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let media):
                DispatchQueue.main.async {
                    let mediaStrings: [String] = self.convertMediaToStringArray(media: media)
                    
                    self.mediaImage.downloaded(from: mediaStrings[0], contentMode: .scaleAspectFill)
                    self.romajiTitle.text           = mediaStrings[1]
                    
                    if (mediaStrings[2] != "")      { self.japaneseTitle.text    = mediaStrings[2] }
                    if (mediaStrings[3] != "")      { self.japaneseTitle.text?.append("\n(\(mediaStrings[3]))") }
                    if (mediaStrings[5] != "-1")    { self.seasonYearLabel.text  = mediaStrings[4] + " " + mediaStrings[5] }
                    
                    self.id = media.id
                }
                return
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}
