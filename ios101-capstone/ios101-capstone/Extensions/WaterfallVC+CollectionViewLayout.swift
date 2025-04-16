//
//  WaterfallVC+CollectionViewLayout.swift
//  ios101-capstone
//
//  Modified by Benjamin Nguyen on 4/13/2025.
//  Original file credit to Vebjørn Daniloff: https://github.com/vebbis321/WaterfallCompostionalLayout
//  Package credit to Evgenii Shishko: https://github.com/eeshishko/WaterfallTrueCompositionalLayout
//

import UIKit
import AniListAPI
import WaterfallTrueCompositionalLayout

// MARK: - WaterFallLayout
extension WaterfallVC {
    static func createWaterFallLayout(env: NSCollectionLayoutEnvironment, items: [PaginationQuery.Data.Page.Medium]) -> NSCollectionLayoutSection {
        
        let configuration = WaterfallTrueCompositionalLayout.Configuration(
            columnCount: 2,
            interItemSpacing: 8,
            contentInsetsReference: .automatic,
            itemCountProvider: {
                return items.count
            },
            itemHeightProvider: { index, itemWidth in
                return itemWidth * CGFloat.random(in: 1...1.5)
            }
        )
    
        let layout = WaterfallTrueCompositionalLayout.makeLayoutSection(
                config: configuration,
                environment: env,
                sectionIndex: 1
            )
        
        return layout
    }
}
