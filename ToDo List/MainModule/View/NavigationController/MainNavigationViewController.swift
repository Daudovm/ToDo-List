//
//  MainNavigationViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 31.07.2024.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    private let iconMobImage = UIImageView()
    private let titleMob = UILabel()
    private let pushButton = UIButton()
 
    var pushClouser: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        createElements()
    }
    private func createElements() {
        
        iconMobImage.image = UIImage(named: "Icon")
       
        titleMob.text = "ToDo List"
        titleMob.font = .boldSystemFont(ofSize: 20)
        
        pushButton.setBackgroundImage(UIImage(systemName: "bell"), for: .normal)
        pushButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        pushButton.tintColor = UIColor(red: 1, green: 0.1764705882, blue: 0.3215686275, alpha: 1)
        
        let icon = UIBarButtonItem(customView: iconMobImage)
        let title = UIBarButtonItem(customView: titleMob)
        let button = UIBarButtonItem(customView: pushButton)
  
        guard let topVC = topViewController else { return }
        
        iconMobImage.clipsToBounds = true
        icon.customView?.translatesAutoresizingMaskIntoConstraints = false
        icon.customView?.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            icon.customView!.heightAnchor.constraint(equalToConstant: 45),
            icon.customView!.widthAnchor.constraint(equalToConstant:45),
            
            button.customView!.heightAnchor.constraint(equalToConstant: 30),
            button.customView!.widthAnchor.constraint(equalToConstant:30),
        ])
        topVC.navigationItem.leftBarButtonItems = [icon,title]
        topVC.navigationItem.rightBarButtonItem = button
    }
    
    @objc func buttonAction(sender: UIButton) {
        pushClouser?()
    }
}
