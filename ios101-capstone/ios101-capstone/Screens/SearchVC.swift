//
//  SearchVC.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/12/25.
//

import UIKit
import Apollo
import AniListAPI

class SearchVC: UIViewController {
    
    // MARK: - Init variables
    enum Section { case main }
    
    //  Subviews
    let logoImageView           = UIImageView()
    let searchQueryTextField    = CustomTextField()
    let callToActionbutton      = CustomButton(backgroundColor: UIColor(hex: HexColors.button)!, title: "Search")
    
    //  Subview variables
    var isSearchQueryEntered: Bool { return !searchQueryTextField.text!.isEmpty }
    
    //  MARK: - View initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: HexColors.background)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDissmissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //  MARK: - Subview configuration
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "feather-logo")!
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func configureTextField() {
        view.addSubview(searchQueryTextField)
        NSLayoutConstraint.activate([
            searchQueryTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            searchQueryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchQueryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchQueryTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionbutton)
        callToActionbutton.addTarget(self, action: #selector(pushWaterfallVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionbutton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createDissmissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushWaterfallVC() {
        guard isSearchQueryEntered else { return }
        
        let waterfallVC = WaterfallVC()
        waterfallVC.searchQuery = searchQueryTextField.text!
        navigationController?.pushViewController(waterfallVC, animated: true)
    }
    
}

// MARK: - SearchVC Extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tap return")
        return true
    }
}
