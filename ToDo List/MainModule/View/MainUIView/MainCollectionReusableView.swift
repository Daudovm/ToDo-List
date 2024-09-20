//
//  MainCollectionReusableView.swift
//  ToDo List
//
//  Created by Macbook pro on 2.08.2024.
//

import UIKit

class MainCollectionReusableView: UICollectionReusableView {
    
    private let viewGrating = UIView()
    private var circuleView: CircularView!
    private let tileLabel = UILabel()
    private let completedLabel = UILabel()
    
    private let sectionLabel = UILabel()
    private let sectioView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElemented()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupElemented() {
        let radius = self.frame.height / 7
        viewGrating.translatesAutoresizingMaskIntoConstraints = false
        viewGrating.backgroundColor = .white
        viewGrating.layer.cornerRadius = radius
        viewGrating.layer.shadowColor = UIColor.black.cgColor
        viewGrating.layer.shadowOpacity = 0.25
        viewGrating.layer.shadowOffset = CGSize(width: 0, height: 4)
        addSubview(viewGrating)
        
        circuleView = CircularView()
        circuleView.setProgress(to: 0.75, widtAnimation: true, textCenter: "\(75)%")
        circuleView.translatesAutoresizingMaskIntoConstraints = false
        viewGrating.addSubview(circuleView)
        
        tileLabel.text = "Пусть день пройдет продуктивно!"
        tileLabel.numberOfLines = 0
        tileLabel.translatesAutoresizingMaskIntoConstraints = false
        tileLabel.textColor = .black
        tileLabel.font = .boldSystemFont(ofSize: 20)
        viewGrating.addSubview(tileLabel)
        
        completedLabel.text = "Выполнено: 10 из 12"
        completedLabel.numberOfLines = 0
        completedLabel.translatesAutoresizingMaskIntoConstraints = false
        completedLabel.textColor = .gray
        completedLabel.font = .systemFont(ofSize: 16)
        viewGrating.addSubview(completedLabel)
        
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.font = .boldSystemFont(ofSize: 14)
        
        sectioView.layer.cornerRadius = 10
        sectioView.translatesAutoresizingMaskIntoConstraints = false
        sectioView.layer.shadowColor = UIColor.black.cgColor
        sectioView.layer.shadowOpacity = 0.25
        sectioView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        addSubview(sectioView)
        sectioView.addSubview(sectionLabel)
        NSLayoutConstraint.activate([
            
            viewGrating.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            viewGrating.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewGrating.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.93),
            viewGrating.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.576),
            
            circuleView.centerYAnchor.constraint(equalTo: viewGrating.centerYAnchor),
            circuleView.leadingAnchor.constraint(equalToSystemSpacingAfter: viewGrating.leadingAnchor, multiplier: 3.125),
            circuleView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.384),
            circuleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.384),
            
            tileLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: viewGrating.topAnchor, multiplier: 3),
            tileLabel.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: viewGrating.leadingAnchor, multiplier: 16.5),
            tileLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            tileLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23),
            
            completedLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: viewGrating.topAnchor, multiplier: 11),
            completedLabel.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: viewGrating.leadingAnchor, multiplier:16.5),
            completedLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            completedLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.138),
            
            sectioView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sectioView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            sectioView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            sectioView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.19),
            
            sectionLabel.leadingAnchor.constraint(equalTo: sectioView.leadingAnchor, constant: 10),
            sectionLabel.trailingAnchor.constraint(equalTo: sectioView.trailingAnchor, constant: 0),
            sectionLabel.topAnchor.constraint(equalTo: sectioView.topAnchor, constant: 0),
            sectionLabel.bottomAnchor.constraint(equalTo: sectioView.bottomAnchor, constant: 0),
            
        ])
    }
    
    public func getSection(title: String, color: UIColor) {
        sectionLabel.text = title
        sectioView.backgroundColor = color
    }
}
