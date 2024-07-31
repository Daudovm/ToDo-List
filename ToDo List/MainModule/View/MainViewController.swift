//
//  ViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import UIKit

protocol MainViewControllerProtocol {
    func success()
    func failure(error: Error)
}

class MainViewController: UIViewController {

    
    var mainPresenterProtocol: MainPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.9294117647, green: 0.9568627451, blue: 0.9490196078, alpha: 1)
    }


}

extension MainViewController: MainViewControllerProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
}
