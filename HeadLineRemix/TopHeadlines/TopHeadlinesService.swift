//
//  TopHeadlinesService.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

typealias completionSignature = (Result<APIResponseArticle, APIError>) -> Void

class TopHeadlinesService: TopHeadlinesServiceProtocol {
    private var apiClient: APIClient
    
    init(connection: APIClient) {
        apiClient = connection
    }
    func fetchTopHeadlines( completion: @escaping completionSignature){
        guard let urlApi = URL(string: TopHeadlinesAPI.urlGetAllTopHeadlines) else{ return }
        let url = URLRequest(url: urlApi)
        apiClient.get(url: url) { (result: Result<APIResponseArticle, APIError>) in
            completion(result)
        }
    }
}

protocol TopHeadlinesServiceProtocol {
    func fetchTopHeadlines( completion: @escaping completionSignature)
}
