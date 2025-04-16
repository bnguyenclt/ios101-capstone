//
//  UIView+ConvertMediaToStringArray.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/16/25.
//

import UIKit
import AniListAPI

extension UIView {
    //  Converts fetched data into String values.
    func convertMediaToStringArray(media: MediaByIDQuery.Data.Media) -> [String] {
        let coverImage      = media.coverImage?.extraLarge
        let romajiTitle     = media.title?.romaji
        let japaneseTitle   = media.title?.native
        let englishTitle    = media.title?.english
        let season          = media.season?.rawValue
        let seasonYear      = "\(media.seasonYear ?? -1)"
        let episodes        = "\(media.episodes ?? -1)"
        let description     = String(htmlEncodedString: media.description ?? "")
        let averageScore    = "\(media.averageScore ?? -1)"
        let popularity      = "\(media.popularity ?? -1)"
        
        return [
            coverImage ?? "",   //0
            romajiTitle ?? "",  //1
            japaneseTitle ?? "",//2
            englishTitle ?? "", //3
            season ?? "",       //4
            seasonYear,         //5
            episodes,           //6
            description ?? "",  //7
            averageScore,       //8
            popularity          //9
        ]
    }
}

extension UIViewController {
    //  Converts fetched data into String values.
    func convertMediaToStringArray(media: MediaByIDQuery.Data.Media) -> [String] {
        let coverImage      = media.coverImage?.extraLarge
        let romajiTitle     = media.title?.romaji
        let japaneseTitle   = media.title?.native
        let englishTitle    = media.title?.english
        let season          = media.season?.rawValue
        let seasonYear      = "\(media.seasonYear ?? -1)"
        let episodes        = "\(media.episodes ?? -1)"
        let description     = String(htmlEncodedString: media.description ?? "")
        let averageScore    = "\(media.averageScore ?? -1)"
        let popularity      = "\(media.popularity ?? -1)"
        
        return [
            coverImage ?? "",   //0
            romajiTitle ?? "",  //1
            japaneseTitle ?? "",//2
            englishTitle ?? "", //3
            season ?? "",       //4
            seasonYear,         //5
            episodes,           //6
            description ?? "",  //7
            averageScore,       //8
            popularity          //9
        ]
    }
}
