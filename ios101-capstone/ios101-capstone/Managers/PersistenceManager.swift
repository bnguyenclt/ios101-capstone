//
//  PersistenceManager.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/15/25.
//

import Foundation
import AniListAPI
import Apollo
import ApolloSQLite

enum Keys {
    static let favorites = "Favorites"
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    static func save(_ media: [Int], forKey key: String) {
        let encodedData = try! JSONEncoder().encode(media)
        defaults.set(encodedData, forKey: key)
    }
    
    static func getFavorites(forKey key: String) -> [Int] {
        guard let data = defaults.object(forKey: key) as? Data else { return [] }
        let decodedMedia = try! JSONDecoder().decode([Int].self, from: data)
        return decodedMedia
    }
    
    static func addToFavorites(for id: Int) {
        var favorites: [Int] = PersistenceManager.getFavorites(forKey: Keys.favorites)
        guard !favorites.contains(id) else { return }
        favorites.append(id)
        PersistenceManager.save(favorites, forKey: Keys.favorites)
    }
    
    static func removeFromFavorites(for id: Int) {
        var favorites = PersistenceManager.getFavorites(forKey: Keys.favorites)
        favorites.removeAll { $0 == id }
        PersistenceManager.save(favorites, forKey: Keys.favorites)
    }
}
