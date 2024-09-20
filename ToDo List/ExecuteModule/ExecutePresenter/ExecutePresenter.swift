//
//  ExecutePresenter.swift
//  ToDo List
//
//  Created by Macbook pro on 10.09.2024.
//

import Foundation

protocol ExecutePresenterProtocol: AnyObject {
    init(view: ExecuteViewControllerProtocol, networkServise: NetworkServiceProrocol)
    func getFetch()
    func getRemove(model: MainModel)
    var arrayModels: [MainModel]? { get set}
}

class ExecutePresenter: ExecutePresenterProtocol {
    
    var arrayModels: [MainModel]?
    weak var view: ExecuteViewControllerProtocol?
    let networkService: NetworkServiceProrocol!
    
    required init(view: ExecuteViewControllerProtocol, networkServise: NetworkServiceProrocol) {
        self.view = view
        self.networkService = networkServise
        getFetch()
    }
    
    func getFetch() {
        networkService.fetch { result in
            switch result {
            case .success(let data):
                self.getStarted(data)
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    private func getStarted(_ main: [MainModel]) {
        var models = [MainModel]()
        main.forEach { model in
            if model.pausa {
                models.append(model)
            }
        }
        arrayModels = models
    }
    
    func getRemove(model: MainModel) {
        networkService.delete(task: model)
    }
}
