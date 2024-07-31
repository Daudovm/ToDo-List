//
//  NetworkService.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import Foundation
import SwiftData

protocol NetworkServiceProrocol {
    func fetch(complection: @escaping (Result<[MainModel], Error>) -> Void)
    func save(task: MainModel)
    func delete(task: MainModel)
}

class NetworkService: NetworkServiceProrocol {
    
    var conteiner: ModelContainer?
    var contex: ModelContext?
    
    init() {
        do {
            let schema = Schema([MainModel.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            conteiner = try ModelContainer(for: schema, configurations: modelConfiguration)
            if let conteiner {
                contex = ModelContext(conteiner)
            }
        }catch {
            print(error)
        }
    }
    func fetch(complection: @escaping (Result<[MainModel], Error>) -> Void) {
        let description = FetchDescriptor<MainModel>(sortBy: [SortDescriptor<MainModel>]())
        do {
            guard let data = try contex?.fetch(description) else { return }
            complection(.success(data))
        }catch {
            complection(.failure(error))
        }
    }
    
    func save(task: MainModel) {
        contex?.insert(task)
    }
    
    func delete(task: MainModel) {
        contex?.delete(task)
    }
    
    
}
