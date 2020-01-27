//
//  AppCoordinator.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/21/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private var navigationController: UINavigationController
    private var coordinator: TopHeadlinesCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        coordinator = TopHeadlinesFeature.make(connection: APIClient(), nav: navigationController)
        guard let view = coordinator?.start() else{return}
        navigationController.pushViewController(view, animated: true)
    }
    deinit {
        print("deinit of appcordinator ")
    }
}
