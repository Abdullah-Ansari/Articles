//
//  APIs.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

// MARK: - METHOD'S TYPE
enum HTTPMethod: String {
    case get = "GET"
}

// MARK: - BASE URL
enum BaseURL: String {

    case baseURL

    var value: String {
        switch self {
        case .baseURL:
            return "api.nytimes.com"
        }
    }
}

// MARK: - PATH
enum Path: String {

    case getArticles

    var value: String {
        switch self {
        case .getArticles:
            return "/svc/mostpopular/v2/mostviewed/all-sections/7.json"
        }
    }
}

