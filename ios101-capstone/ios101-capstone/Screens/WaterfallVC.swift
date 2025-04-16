//
//  WaterfallVC.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/12/25.
//

import UIKit
import Apollo
import AniListAPI

class WaterfallVC: UIViewController {
    
    // MARK: - Init variables
    enum Section { case main }
    
    var searchQuery: String!
    var mediaArray: [PaginationQuery.Data.Page.Medium] = []
    var currentPage: Int = 1
    var hasNextPage: Bool = true
    var tappedCellID: Int!

    //  Data source
    var dataSource: UICollectionViewDiffableDataSource<Section, PaginationQuery.Data.Page.Medium>!
    
    //  Subviews
    var collectionView: UICollectionView!
    
    //  MARK: - View initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getData(page: currentPage)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Subview initialization
    private func configureViewController() {
        view.backgroundColor = UIColor(hex: HexColors.background)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor(hex: HexColors.background)
        collectionView.delegate = self
        collectionView.register(WaterfallDataCell.self, forCellWithReuseIdentifier: WaterfallDataCell.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionNumber, env in
            guard let self = self else { fatalError() }
            return WaterfallVC.createWaterFallLayout(env: env, items: self.mediaArray)
            }
        return layout
    }
    
    // Detects tapping on each UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView,
             didSelectItemAt indexPath: IndexPath) {
        let tappedCell = collectionView.cellForItem(at:indexPath) as! WaterfallDataCell
        self.tappedCellID = tappedCell.id
        pushMediaDetailVC()
    }
    
    @objc func pushMediaDetailVC() {
        let mediaDetailVC = MediaDetailVC()
        mediaDetailVC.id = tappedCellID
        navigationController?.pushViewController(mediaDetailVC, animated: true)
    }
    
    // MARK: - Data source configuration
    func getData(page: Int) {
        NetworkManager.shared.getPage(id: nil, page: page, perPage: 30, search: searchQuery) { [weak self] result in
            guard let self = self else { return }
            guard let page: PaginationQuery.Data.Page = try? result.get() else { return }
                    
            let medium = page.media as! [PaginationQuery.Data.Page.Medium]
            let hasNextPage = page.pageInfo?.hasNextPage as! Bool
            // Updates mediaArray with contents of result
            self.mediaArray.append(contentsOf: medium)
            // If result has a next page, set hasNextPage to true
            self.hasNextPage = hasNextPage
            // Update data within collection view.
            self.updateData()
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, PaginationQuery.Data.Page.Medium>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, media) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterfallDataCell.reuseIdentifier, for: indexPath) as! WaterfallDataCell
                cell.set(media: media)
                return cell
            })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PaginationQuery.Data.Page.Medium>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mediaArray)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

// MARK: - WaterfallVC Extensions
extension WaterfallVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasNextPage else { return }
            currentPage += 1
            getData(page: currentPage)
        }
    }
}
