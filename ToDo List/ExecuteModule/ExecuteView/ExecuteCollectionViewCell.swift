//
//  ExecuteCollectionViewCell.swift
//  ToDo List
//
//  Created by Macbook pro on 20.09.2024.
//

import UIKit

class ExecuteCollectionViewCell: UICollectionViewCell {
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let stopButton = UIButton()
    public var removeActionClouser: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let radius = contentView.frame.height / 3.33
        contentView.backgroundColor = .white
                contentView.layer.cornerRadius = radius
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.layer.cornerRadius = mainImage.frame.width / 4
        contentView.addSubview(mainImage)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)

     
        
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.setBackgroundImage(UIImage(named: "stop"), for: .normal)
//        stopButton.backgroundColor = UIColor(red: 0.1490196078, green: 0.7882352941, blue: 0.4196078431, alpha: 1)
        stopButton.addTarget(self, action: #selector(removeAction(sender:)), for: .touchUpInside)
        stopButton.tintColor = .white
        contentView.addSubview(stopButton)
        
        NSLayoutConstraint.activate([
            mainImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainImage.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.25),
            mainImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80),
            mainImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: mainImage.trailingAnchor, multiplier: 1.25),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80),
            
            stopButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            stopButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stopButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            stopButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
        ])
    }
    @objc func removeAction(sender: UIButton) {
        removeActionClouser?()
    }
    
    public func makeModel(_ main: MainModel) {
        mainImage.image = UIImage(named: "\(main.image)")
        titleLabel.text = main.title
    }
    
    override func layoutSubviews() {
        stopButton.layer.cornerRadius = stopButton.frame.height / 2
    }
}
