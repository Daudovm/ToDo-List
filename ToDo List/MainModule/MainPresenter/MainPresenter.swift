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
    func update(main: MainModel, isStarted: Bool)
    func getDelete(_ model: MainModel)
//    var mainModels: [MainModel]? { get set }
    var mainModels: [[MainModel]]? { get set }
}

class MainPresenter: MainPresenterProtocol {
    

    var mainModels: [[MainModel]]?
    var networkServise: NetworkService!
    weak var view: MainViewControllerProtocol?

    
    required init(view: MainViewControllerProtocol, network: NetworkService) {
        self.view = view
        self.networkServise = network
        getFetch()
    }
    
    func getFetch() {
        networkServise.fetch { result in
            switch result {
            case .success(let data):
                self.splitArrayIntoSections(data)
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func splitArrayIntoSections(_ array: [MainModel]) {
        let date = Date()
        var arraymain: [[MainModel]] = [[],[],[],[]]
        
        array.forEach({ model in
            let modelTime = model.time.timeIntervalSince(date)
            switch modelTime {
            case 0...86400: arraymain[0].append(model)
            case 86400...604800: arraymain[1].append(model)
            case 604800...1209600:arraymain[2].append(model)
            case _ where modelTime >= 1209600: arraymain[3].append(model)
            default:
                self.getDelete(model)
            }
        })
        mainModels = arraymain
    }
    
    func update(main: MainModel, isStarted: Bool) {
        networkServise.update(task: main, isStarted: isStarted)
        getFetch()
    }
    
    func getDelete(_ model: MainModel) {
        self.networkServise.delete(task: model)
        getFetch()
    }
}
