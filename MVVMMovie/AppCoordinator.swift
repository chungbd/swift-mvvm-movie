//
//  AppCoordinator.swift
//  MVVMMovie
//
//  Created by Bui Chung on 29/10/2021.
//

import Foundation
import UIKit

class AppCoordinator {
    let window:UIWindow
    var navigation:UINavigationController?
    
    init(window:UIWindow) {
        self.window = window
    }
        
    func start() -> Void {
        let viewController = ViewController.instantiate(viewModel: PosterListViewModel())
        viewController.coordinator = self
        navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation!
        window.makeKeyAndVisible()
    }
    
    func goToDetail(model:Movie) {        
        DispatchQueue.main.async {
            let viewController = DetailVC.instantiate(viewModel: DetailViewModel(movie: model))
            viewController.coordinator = self

            self.navigation?.pushViewController(viewController, animated: true)
        }
        
    }
}
