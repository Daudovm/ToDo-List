//
//  HeaderView.swift
//  ToDo List
//
//  Created by Macbook pro on 16.08.2024.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let reuseIdentifier = "header-reuse-identifier"
        
        private let label = UILabel()
        private let view = UIView()
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    public func getTitle(title: String, color: UIColor) {
        label.text = title
        view.backgroundColor = color
    }
        private func configure() {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 14)
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.25
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            addSubview(view)
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                view.centerYAnchor.constraint(equalTo: centerYAnchor),
                view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.625),

                
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        }
}
