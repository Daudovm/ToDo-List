//
//  MainPresenter.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewControllerProtocol, network: NetworkService)
    func getFetch()
    func getSave(_ model: MainModel)
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
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func getSave(_ model: MainModel) {
        self.networkServise.save(task: model)
        getFetch()
    }
    
    func getDelete(_ model: MainModel) {
        self.networkServise.delete(task: model)
        getFetch()
    }
}
