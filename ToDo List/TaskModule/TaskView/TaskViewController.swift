//
//  TaskViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 27.08.2024.
//

import UIKit

protocol TaskViewControllerProtocol {
    func success()
}
class TaskViewController: UIViewController {

    public var taskPresenter: TaskPresenterProtocol?
    var clouserDelete: (() -> Void)?
    let taskButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        taskButton.setTitle("удалить", for: .normal)
        taskButton.setTitleColor(.blue, for: .normal)
        taskButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        taskButton.center = view.center
        taskButton.addTarget(self, action: #selector(removeAction(sender:)), for: .touchUpInside)
        view.addSubview(taskButton)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
  
    }
    @objc func removeAction(sender: UIButton) {
        clouserDelete?()
        dismiss(animated: true)
    }
}

extension TaskViewController: TaskViewControllerProtocol {
    func success() {
        
    }
}
