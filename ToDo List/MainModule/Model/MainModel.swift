//
//  MainModel.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import Foundation
import SwiftData

@Model
class MainModel {
    @Attribute(.unique) var id: UUID
    var image: String
    var title: String
    var descriptions: String
    var time: Date
    var pausa: Bool
    
    init(id: UUID = UUID(),image: String, title: String, descriptions: String, time: Date,  pausa: Bool) {
        self.image = image
        self.id = id
        self.title = title
        self.descriptions = descriptions
        self.time = time
        self.pausa = pausa
    }
}

