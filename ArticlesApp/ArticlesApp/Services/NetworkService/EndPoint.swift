//
//  EndPoint.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

protocol EndPoint {

    var path: Path { get set }
    var method: HTTPMethod { get set }
    var baseURL: BaseURL { get set }
    var paramters: [String: String]? { get set }
    var url: URL? { get }
}

struct EndPointImpl: EndPoint {

    var path: Path = .getArticles
    var method: HTTPMethod = .get
    var baseURL: BaseURL = .baseURL
    var paramters: [String : String]?

    var url: URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL.value
        components.path = path.value
        components.queryItems = paramters?.map { URLQueryItem(name: $0.key, value: $0.value )}
        return components.url
    }
}
