//
//  TabBarViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let mainViewController = Builder.createMainView()
    
    private lazy var btn1 = getButton(icon: "house.fill", tag: 0, action: action, color: .gray)
    private lazy var btn2 = getButton(icon: "plus.circle.fill", tag: 1, action: action, color: .gray)
    private lazy var btn3 = getButton(icon: "clock", tag: 2, action: action, color: .gray)
    
    private lazy var action = UIAction { [weak self] sender in
        guard let sender = sender.sender as? UIButton,
                let self = self else {return}
        self.selectedIndex = sender.tag
        self.setOpacite(tag: sender.tag)
        self.getPresent(tag: sender.tag)
    }
    
    
    private lazy var stackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(btn1)
        $0.addArrangedSubview(btn2)
        $0.addArrangedSubview(btn3)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.25
        $0.addArrangedSubview(UIView())

        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        setupConstraint()
        setOpacite(tag: 0)
        tabBar.isHidden = true
        setViewControllers([mainViewController], animated: true)
       
    }
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            btn2.widthAnchor.constraint(equalToConstant: 50),
            btn2.heightAnchor.constraint(equalToConstant: 50),
        ])
        [btn1, btn3].forEach { btn in
            NSLayoutConstraint.activate([
                btn.widthAnchor.constraint(equalToConstant: 30),
                btn.heightAnchor.constraint(equalToConstant: 30),
            ])
            }
    }
    
    private func getPresent(tag: Int) {
        if tag == 1 {
            let addVC = Builder.createAddView()
            self.present(addVC, animated: true, completion: nil)
        }
    }
    
    private func getButton(icon:String, tag: Int, action: UIAction, color: UIColor ) -> UIButton {
        return {
            $0.setBackgroundImage(UIImage(systemName: icon), for: .normal)
            $0.tintColor = color
            $0.tag = tag
           return $0
        }(UIButton(primaryAction: action))
    }
    
    private func setOpacite(tag: Int) {
        btn2.tintColor = UIColor(red: 1, green: 0.1764705882, blue: 0.3215686275, alpha: 1)
        btn1.tintColor = UIColor(red: 1, green: 0.1764705882, blue: 0.3215686275, alpha: 1)
        [btn1, btn3].forEach { btn in
            if btn.tag != tag {
                btn.tintColor = .gray
            }else {
                btn.tintColor = UIColor(red: 1, green: 0.1764705882, blue: 0.3215686275, alpha: 1)
            }
        }
    }
}



