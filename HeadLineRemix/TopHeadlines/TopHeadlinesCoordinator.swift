//
//  TopHeadlinesCoordinator.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit

class TopHeadlinesCoordinator{
    struct Dependencies {
        let interactor: TopHeadlinesInteractor
        let formatter: TopHeadlinesFormatter
        let view: TopHeadlinesViewProtocol
    }
    
    private let deps: Dependencies
    private var topHeadlinesDetailCoordinator: TopHeadlinesDetailCoordinator?
    
    init(deps: Dependencies) {
        self.deps = deps
        deps.view.setDelegate(delegate: self)
        deps.interactor.setDelegate(delegate: self)
    }
    
    func start() -> UIViewController?{
        return deps.view as? UIViewController
    }
    
    
    deinit {
        print("deinit of coordinator")
    }
}

//  MARK: - AdvertListViewDelegate
extension TopHeadlinesCoordinator: AdvertListViewDelegate{
    func viewIsReady() {
        deps.interactor.fetchArticles()
    }
    
    func didSelect(article: TopHeadlinesDetailViewData) {
        guard let view = self.deps.view as? UIViewController else{ return }
        guard let topHeadlinesDetailCoordinator = topHeadlinesDetailCoordinator else{
            self.topHeadlinesDetailCoordinator = TopHeadlinesDetailFeature.make()
            self.topHeadlinesDetailCoordinator?.setArticle(article: article)
            self.topHeadlinesDetailCoordinator?.start(viewParent: view)
            return
        }
        topHeadlinesDetailCoordinator.setArticle(article: article)
        topHeadlinesDetailCoordinator.start(viewParent: view)
    }
        
}

//  MARK: - TopHeadlinesInteractorDelegate
extension TopHeadlinesCoordinator: TopHeadlinesInteractorDelegate{
    func didFetchTopheadline(article: [Article]) {
        let articles = self.deps.formatter.prepareData(articles: article)
        self.deps.view.updateView(articles: articles)
    }
    
    func didFetchTopHeadline(with message: String) {
        self.deps.view.showErrorMessage(message: message)
    }
}
