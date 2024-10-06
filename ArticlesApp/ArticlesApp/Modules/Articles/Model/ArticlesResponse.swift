//
//  ArticlesResponse.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation


// MARK: - ArticleResponse
public struct ArticlesResponse: Decodable, Equatable {
    let status, copyright: String?
    let numResults: Int?
    let results: [Article]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
public struct Article: Decodable, Equatable {
    let uri: String?
    let url: String?
    let id, assetID: Int?
    let source: Source?
    let publishedDate, updated, section, subsection: String?
    let nytdsection, adxKeywords: String?
    let title, abstract, byline: String?
    let desFacet, orgFacet, perFacet, geoFacet: [String]?
    let media: [Media]?
    let etaID: Int?
    var imageURL: URL? {
        guard
            let media = media,
            let last = media.last?.mediaMetadata?.last,
                let articleImageString = last.url else { return nil }
        return URL(string: articleImageString)
    }
    
    var articleURL: URL? {
        guard
            let urlString = url, !urlString.isEmpty else { return nil }
        
        return URL(string: urlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case title, abstract, byline
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}

// MARK: - Media
public struct Media: Decodable, Equatable {
    let type: MediaType?
    let subtype: Subtype?
    let caption, copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
public struct MediaMetadatum: Decodable, Equatable {
    let url: String?
    let format: Format?
    let height, width: Int?
}

public enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

public enum Subtype: String, Decodable, Equatable {
    case empty = ""
    case photo = "photo"
}

public enum MediaType: String, Decodable, Equatable {
    case image = "image"
}

public enum Source: String, Decodable, Equatable {
    case newYorkTimes = "New York Times"
}
