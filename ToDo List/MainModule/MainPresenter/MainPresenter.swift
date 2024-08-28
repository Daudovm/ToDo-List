//
//  MainPresenter.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewControllerProtocol, network: NetworkService)
    func getFetch()
    func update()
    func getDelete(_ model: MainModel)
    var mainModels: [MainModel]? { get set }
}

class MainPresenter: MainPresenterProtocol {
    
    var mainModels: [MainModel]?
    var networkServise: NetworkService!
    var view: MainViewControllerProtocol?
    
    required init(view: MainViewControllerProtocol, network: NetworkService) {
        self.view = view
        self.networkServise = network
        getFetch()
    }
    
    func getFetch() {
        networkServise.fetch { result in
            switch result {
            case .success(let data):
                self.mainModels = data
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func update() {
        getFetch()
        self.view?.success()
    }
    
    func getDelete(_ model: MainModel) {
        self.networkServise.delete(task: model)
        getFetch()
    }
}
