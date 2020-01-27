//
//  TopHeadlinesDetailFeature.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/22/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation

class TopHeadlinesDetailFeature {
    static func make() -> TopHeadlinesDetailCoordinator{
        let view = TopHeadlinesDetailViewController.makeView()
        let deps = TopHeadlinesDetailCoordinator.Dependencies(view: view)
        return TopHeadlinesDetailCoordinator(deps: deps)
    }
}
