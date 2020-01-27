//
//  TopHeadlinesInteractor.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

protocol TopHeadlinesInteractorDelegate: AnyObject {
    func didFetchTopheadline(article: [Article])
    func didFetchTopHeadline(with message: String)
}

class TopHeadlinesInteractor {
    private let service: TopHeadlinesServiceProtocol?
    private weak var delegate: TopHeadlinesInteractorDelegate?
    
    init(service: TopHeadlinesServiceProtocol) {
        self.service = service
    }
    
    func setDelegate(delegate: TopHeadlinesInteractorDelegate){
        self.delegate = delegate
    }
    
    func fetchArticles(){
        service?.fetchTopHeadlines(completion: { (result) in
            switch result{
            case .success(let response):
                guard let articles = response.articles else{ return }
                self.delegate?.didFetchTopheadline(article: articles)
            case .failure(let error):
                self.delegate?.didFetchTopHeadline(with: error.localizedDescription)
            }
        })
    }
}

