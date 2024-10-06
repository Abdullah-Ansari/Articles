//
//  NetworkServiceTests.swift
//  ArticlesAppTests
//
//  Created by Abdullah Ansari on 06/10/24.
//

import XCTest
@testable import ArticlesApp

class NetworkServiceTests: XCTestCase {
    
    var sut: NetworkService!
    var configuration: URLSessionConfiguration!
    
    override func setUp() {
        super.setUp()
        configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = NetworkService(urlSession: session)
    }
    
    override func tearDown() {
        sut = nil
        configuration = nil
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = nil
        super.tearDown()
    }
    
    func testRequestSuccess() async throws {
        
        let mockData = """
        {
            "status": "OK",
            "copyright": "Copyright (c) 2024 The New York Times Company. All Rights Reserved.",
            "num_results": 1,
            "results": [
                {
                    "uri": "nyt://article/123",
                    "url": "https://www.nytimes.com/2024/01/01/world/test-article.html",
                    "id": 100000008980123,
                    "asset_id": 100000008980123,
                    "source": "New York Times",
                    "published_date": "2024-01-01",
                    "updated": "2024-01-01 12:00:00",
                    "section": "World",
                    "subsection": "",
                    "nytdsection": "world",
                    "adx_keywords": "Test;Article",
                    "title": "Test Article",
                    "abstract": "This is a test article abstract.",
                    "byline": "By Bill Friskics-Warren",
                    "des_facet": ["Test"],
                    "org_facet": ["New York Times"],
                    "per_facet": [],
                    "geo_facet": [],
                    "media": [],
                    "eta_id": 0
                }
            ]
        }
        """.data(using: .utf8)!
        
        let endPoint = EndPointBuilder()
            .setPath(.getArticles)
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .build()
        
        let mockResponse = HTTPURLResponse(url: endPoint.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockData = mockData
        MockURLProtocol.mockResponse = mockResponse
        
        let result: ArticlesResponse = try await sut.request(endPoint: endPoint)
        
        XCTAssertEqual(result.status, "OK")
        XCTAssertEqual(result.numResults, 1)
        XCTAssertEqual(result.results?.first?.title, "Test Article")
    }
    
    func testRequestFailureBadURL() async {
        
        let endPoint = EndPointBuilder()
            .setPath(.invalidURL)
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .build()
        
        do {
            let _: ArticlesResponse = try await sut.request(endPoint: endPoint)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .badURL)
        }
    }
    
    func testRequestFailureBadServerResponse() async {
        
        let endPoint = EndPointBuilder()
            .setPath(.getArticles)
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .build()
        let mockResponse = HTTPURLResponse(url: endPoint.url!, statusCode: 404, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockData = Data()
        MockURLProtocol.mockResponse = mockResponse
    
        do {
            let _: ArticlesResponse = try await sut.request(endPoint: endPoint)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
    
    func testRequestFailureDecodingError() async {
        
        let endPoint = EndPointBuilder()
            .setPath(.getArticles)
            .setMethod(.get)
            .setBaseURL(.baseURL)
            .build()
        let invalidJSONData = "Invalid JSON".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: endPoint.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockURLProtocol.mockData = invalidJSONData
        MockURLProtocol.mockResponse = mockResponse
       
        do {
            let _: ArticlesResponse = try await sut.request(endPoint: endPoint)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}
