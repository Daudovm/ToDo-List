//
//  TaskPresenter.swift
//  ToDo List
//
//  Created by Macbook pro on 27.08.2024.
//

import Foundation

protocol TaskPresenterProtocol: AnyObject {
    init(view: TaskViewControllerProtocol, network: NetworkServiceProrocol, model: MainModel)
    var model: MainModel? { get set }
}

class TaskPresenter: TaskPresenterProtocol {
    
    var network: NetworkServiceProrocol!
    var model: MainModel?
    weak var view: TaskViewControllerProtocol?
    
    required init(view: TaskViewControllerProtocol, network: NetworkServiceProrocol, model: MainModel) {
        self.network = network
        self.view = view
        self.model = model
    }

}
