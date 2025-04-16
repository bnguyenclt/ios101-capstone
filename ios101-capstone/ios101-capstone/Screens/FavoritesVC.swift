//
//  FavoritesVC.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/12/25.
//

import UIKit

class FavoritesVC: UIViewController {
    
    // MARK: - Init variables
    
    var tableView: UITableView  = UITableView()
    var favorites: [Int]        = []
    var tappedCellID: Int!
    
    //  MARK: - View initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        tableView.reloadData()
        tableView.dragInteractionEnabled = false
    }
    
    @objc func editTapped() {
        switch tableView.dragInteractionEnabled {
        case true:
            tableView.dragInteractionEnabled = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        case false:
            tableView.dragInteractionEnabled = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
    }
    
    func getFavorites() {
        self.favorites = PersistenceManager.getFavorites(forKey: Keys.favorites)
    }
    
    //  MARK: - Subview initialization
    private func configureViewController() {
        view.backgroundColor = UIColor(hex: HexColors.background)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.frame             = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.backgroundColor   = .clear
        tableView.separatorColor    = UIColor.white
        tableView.separatorStyle    = .singleLine
        
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.dragDelegate      = self
    }
    
}


//  MARK: - Extensions

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = favorites[indexPath.row]
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = favorites.remove(at: sourceIndexPath.row)
        favorites.insert(mover, at: destinationIndexPath.row)
        PersistenceManager.save(favorites, forKey: Keys.favorites)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as! FavoriteCell
        let favorite    = favorites[indexPath.row]
        cell.set(for: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
        self.tappedCellID = tappedCell.id
        pushMediaDetailVC()
    }
    
    @objc func pushMediaDetailVC() {
        let mediaDetailVC = MediaDetailVC()
        mediaDetailVC.id = tappedCellID
        navigationController?.pushViewController(mediaDetailVC, animated: true)
    }
    
}
