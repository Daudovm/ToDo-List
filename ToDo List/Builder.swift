//
//  Builder.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import Foundation
import UIKit

protocol BuilderProtocol {
   static func createMainView() -> UIViewController
    static func createAddView() -> UIViewController
}

class Builder: BuilderProtocol {
    
    static func createMainView() -> UIViewController {
        let mainVC = MainViewController()
        let network = NetworkService()
        let presenter = MainPresenter(view: mainVC, network: network)
        mainVC.mainPresenterProtocol = presenter
        let nav = MainNavigationViewController(rootViewController: mainVC)
        nav.pushClouser = { mainVC.notification?() }
        return nav
    }
    
    static func createAddView() -> UIViewController {
        let addVC = AddViewController()
        let network = NetworkService()
        let presenter = AddPresenter(view: addVC, networkService: network)
        addVC.addPresenter = presenter
        return addVC
    }
}
