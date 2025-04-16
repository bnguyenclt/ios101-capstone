//
//  MediaDetailVC.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/12/25.
//

import UIKit
import Apollo
import AniListAPI

class MediaDetailVC: UIViewController {
    
    //  MARK: - Init variables
    var id: Int!
    
    //  Subviews
    let mediaImageView          = UIImageView()
    let romajiTitle             = CustomLabel()
    let japaneseTitle           = CustomLabel()
    let seasonYearLabel         = CustomLabel()
    let episodesLabel           = CustomLabel()
    let descriptionLabel        = CustomLabel()
    let popularityLabel         = CustomLabel()
    let genresLabel             = CustomLabel()
    
    let scrollView      = UIScrollView()
    let stackView       = UIStackView()
    
    //  MARK: - View initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: HexColors.background)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        configureScrollView()
        configureStackView()
        configureMediaImageView()
        configureTitleLabels()
        configureDescriptionLabels()
        
        switch PersistenceManager.getFavorites(forKey: Keys.favorites).contains(id) {
        case true:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(addTapped))
        case false:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        NetworkManager.shared.getMedia(for: id) { [weak self] result in
            guard let self = self else { return }
            guard let media: MediaByIDQuery.Data.Media = try? result.get() else { return }
            
            let mediaStrings: [String] = self.convertMediaToStringArray(media: media)
            
            self.mediaImageView.downloaded(from: mediaStrings[0], contentMode: .scaleAspectFill)
            self.romajiTitle.text           = mediaStrings[1]
            
            if (mediaStrings[2] != "")      { self.japaneseTitle.text    = mediaStrings[2] }
            if (mediaStrings[3] != "")      { self.japaneseTitle.text?.append("\n(\(mediaStrings[3]))") }
            if (mediaStrings[5] != "-1")    { self.seasonYearLabel.text  = mediaStrings[4] + " " + mediaStrings[5] }
            if (mediaStrings[6] != "-1")    { self.episodesLabel.text    = mediaStrings[6] + " Episodes" }
            if (mediaStrings[7] != "")      { self.descriptionLabel.text = mediaStrings[7] }
            
            if (mediaStrings[8] != "-1")    {
                self.popularityLabel.text = "Average rating of \(mediaStrings[8])/100.\nCurrently favorited by \(mediaStrings[9]) users."
            } else {
                self.popularityLabel.text = "No ratings yet.\nCurrently favorited by \(mediaStrings[9]) users."
            }
            
        }
    }
    
    // MARK: - Helper functions
    
    //  Adds media to favorites if not already within favorites.
    @objc func addTapped() {
        guard ( !PersistenceManager.getFavorites(forKey: Keys.favorites).contains(id) ) else {
            PersistenceManager.removeFromFavorites(for: id)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addTapped))
            print("Successfully removed from favorites.")
            return
        }
        
        NetworkManager.shared.getMedia(for: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let media):
                PersistenceManager.addToFavorites(for: media.id)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.addTapped))
                print("Successfully saved \(media.title?.romaji ?? "") to favorites.")
                return
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    //   MARK: - Subview configuration
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.indicatorStyle = .white
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
    
    func configureStackView() {
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement        = false
        stackView.axis      = .vertical
        stackView.spacing   = 10
        stackView.alignment = .center
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -150),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
    
    
    func configureMediaImageView() {
        stackView.addArrangedSubview(mediaImageView)
        
        mediaImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            mediaImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            mediaImageView.heightAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    func configureTitleLabels() {
        stackView.addArrangedSubview(romajiTitle)
        stackView.addArrangedSubview(japaneseTitle)
        
        romajiTitle.font = romajiTitle.font.withSize(48)
        
        NSLayoutConstraint.activate([
            romajiTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            romajiTitle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            japaneseTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            japaneseTitle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
        ])
    }
    
    func configureDescriptionLabels() {
        let divider      = UIView()
        
        stackView.addArrangedSubview(seasonYearLabel)
        stackView.addArrangedSubview(episodesLabel)
        stackView.addArrangedSubview(popularityLabel)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        divider.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            seasonYearLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            seasonYearLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            episodesLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            episodesLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            popularityLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            popularityLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
        ])
    }
    
}
