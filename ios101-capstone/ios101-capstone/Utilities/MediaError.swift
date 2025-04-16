//
//  MediaError.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/15/25.
//

import Foundation

enum MediaError: String, Error {
    case mediaNotFound = "Media does not exist."
    case pageNotFound = "Page does not exist."
    case unableToFavorite = "Unable to favorite media."
    case alreadyInFavorites = "Already favorited."
}
