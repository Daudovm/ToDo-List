//
//  AddPresenter.swift
//  ToDo List
//
//  Created by Macbook pro on 21.08.2024.
//

import Foundation

protocol AddPresenterProtocol: AnyObject {
    init(view: AddViewControllerProtocol, networkService: NetworkServiceProrocol)
    func getSaves(_ model: MainModel)
    
}

class AddPresenter: AddPresenterProtocol {
    
    weak var view: AddViewControllerProtocol?
    let networkServise: NetworkServiceProrocol!

    required init(view: AddViewControllerProtocol, networkService: NetworkServiceProrocol) {
        self.view = view
        self.networkServise = networkService
    }
    
    func getSaves(_ model: MainModel) {
        
        networkServise.save(task: model)
        view?.succes()
    }
    
    
}
