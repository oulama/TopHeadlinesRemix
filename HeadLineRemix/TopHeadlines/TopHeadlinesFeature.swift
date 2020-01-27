//
//  TopHeadlinesFeature.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit

class TopHeadlinesFeature {

    static func make(topHeadlinesFormatter: TopHeadlinesFormatter = TopHeadlinesFormatter(), connection: APIClient, nav: UINavigationController) -> TopHeadlinesCoordinator{
        let service = TopHeadlinesService(connection: connection)
        let interactor = TopHeadlinesInteractor(service: service)
        let view = TopHeadlinesView.makeView()
        let deps = TopHeadlinesCoordinator.Dependencies(interactor: interactor, formatter: topHeadlinesFormatter, view: view)
        return TopHeadlinesCoordinator(deps: deps)
    }
}
