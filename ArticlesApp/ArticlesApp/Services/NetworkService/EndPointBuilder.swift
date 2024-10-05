//
//  EndPointBuilder.swift
//  ArticlesApp
//
//  Created by Abdullah Ansari on 05/10/24.
//

import Foundation

class EndPointBuilder {

    private var path: Path = .getArticles
    private var method: HTTPMethod = .get
    private var baseURL: BaseURL = .baseURL
    private var parameters: [String: String] = [:]

    // set the path.
    @discardableResult
    func setPath(_ value: Path) -> EndPointBuilder {
        self.path = value
        return self
    }

    // set the HTTPMethod.
    @discardableResult
    func setMethod(_ value: HTTPMethod) -> EndPointBuilder {
        self.method = value
        return self
    }

    // set the BaseURL.
    @discardableResult
    func setBaseURL(_ value: BaseURL) -> EndPointBuilder {
        self.baseURL = value
        return self
    }

    // set the Parameters.
    @discardableResult
    func setParameters(_ value: [String: String]) -> EndPointBuilder {
        self.parameters = value
        return self
    }

    // build the assigned values and return the EndPointImpl concrete type.
    func build() -> EndPoint {
        var endpoint = EndPointImpl()
        endpoint.method = method
        endpoint.path = path
        endpoint.baseURL = baseURL
        endpoint.paramters = parameters
        return endpoint
    }

}
