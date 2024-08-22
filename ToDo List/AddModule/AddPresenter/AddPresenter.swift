//
//  AddPresenter.swift
//  ToDo List
//
//  Created by Macbook pro on 21.08.2024.
//

import Foundation

protocol AddPresenterProtocol: AnyObject {
    init(view: AddViewControllerProtocol, networkService: NetworkService)
    func getSave(_ model: MainModel)
}

class AddPresenter: AddPresenterProtocol {
    
    let view: AddViewControllerProtocol?
    let networkServise: NetworkService!

    required init(view: AddViewControllerProtocol, networkService: NetworkService) {
        self.view = view 
        self.networkServise = networkService
    }
    
    func getSave(_ model: MainModel) {
        networkServise.save(task: model)
        view?.succes()
    }
    
    
}
