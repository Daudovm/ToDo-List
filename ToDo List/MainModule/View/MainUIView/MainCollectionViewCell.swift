//
//  MainCollectionViewCell.swift
//  ToDo List
//
//  Created by Macbook pro on 1.08.2024.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let startButton = UIButton()
    
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
        mainImage.image = UIImage(named: "f")
        contentView.addSubview(mainImage)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.text = "Web Develop"
        contentView.addSubview(titleLabel)

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        timeLabel.text = "56:33"
        contentView.addSubview(timeLabel)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.backgroundColor = UIColor(red: 0.1490196078, green: 0.7882352941, blue: 0.4196078431, alpha: 1)
        startButton.tintColor = .white
        contentView.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            mainImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainImage.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.25),
            mainImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80),
            mainImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: mainImage.trailingAnchor, multiplier: 1.25),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80),
            
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1.25),
            timeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40),
            timeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10),
            
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            startButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            startButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
        ])
    }
    
    func makeModel(_ main: MainModel) {
        mainImage.image = UIImage(named: "\(main.image)")
        titleLabel.text = main.title
    }
    override func layoutSubviews() {
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }
    
}
