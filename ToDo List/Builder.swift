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
    static func createTaskView(_ model: MainModel, delete: @escaping () -> Void) -> UIViewController
    static func createExecuteView() -> UIViewController
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
    
    static func createTaskView(_ model: MainModel, delete: @escaping () -> Void) -> UIViewController {
        let taskView = TaskViewController()
        let network = NetworkService()
        let presenter = TaskPresenter(view: taskView, network: network, model: model)
        taskView.taskPresenter = presenter
        taskView.clouserDelete = {
            delete()
        }
        return taskView
    }
    
    static func createExecuteView() -> UIViewController {
        let executeView = ExecuteViewController()
        let network = NetworkService()
        let presenter = ExecutePresenter(view: executeView, networkServise: network)
        executeView.presenter = presenter
        let navVC = UINavigationController(rootViewController: executeView)
        return navVC
    }
    
    
}
