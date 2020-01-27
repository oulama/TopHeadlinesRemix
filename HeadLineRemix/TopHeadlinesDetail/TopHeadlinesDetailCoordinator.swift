//
//  TopHeadlinesDetailCoordinator.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/22/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit


class TopHeadlinesDetailCoordinator {
    struct Dependencies {
        let view: TopHeadlinesDetailProtocol?
    }
    
    private let deps: Dependencies
    private var article: TopHeadlinesDetailViewData?
    
    init(deps: Dependencies) {
        self.deps = deps
        self.deps.view?.setDelegate(delegate: self)
    }
    
    func setArticle(article: TopHeadlinesDetailViewData){
        self.article = article
    }
    
    func start(viewParent: UIViewController){
        guard let vc = deps.view as? UIViewController else{ return }
        viewParent.navigationController?.pushViewController(vc, animated: true)
    }
}

//  MARK: - TopHeadlinesDetailDelegate
extension TopHeadlinesDetailCoordinator: TopHeadlinesDetailDelegate{
    func viewIsReady() {
        guard let article = article else{ return }
        self.deps.view?.updateView(article: article)
    }
}
