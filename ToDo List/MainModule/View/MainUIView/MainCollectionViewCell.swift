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
//    private let timeLabel = UILabel()
    private let startButton = UIButton()
    private var timer: Timer?
//    private let dates = Date()
    var startAction: (() -> ())?
    
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
//
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        timeLabel.font = .systemFont(ofSize: 12)
//        timeLabel.textColor = .gray
//       
//        contentView.addSubview(timeLabel)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        startButton.backgroundColor = UIColor(red: 0.1490196078, green: 0.7882352941, blue: 0.4196078431, alpha: 1)
        startButton.addTarget(self, action: #selector(setupStartAction), for: .touchUpInside)
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
            
//            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            timeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1.25),
//            timeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40),
//            timeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10),
            
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            startButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            startButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
        ])
    }
    
    public func makeModel(_ main: MainModel) {
        mainImage.image = UIImage(named: "\(main.image)")
        titleLabel.text = main.title
        if main.pausa {
            startButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            startButton.backgroundColor =  UIColor(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        }else {
            startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            startButton.backgroundColor = UIColor(red: 0.1490196078, green: 0.7882352941, blue: 0.4196078431, alpha: 1)
        }
    }
    @objc func setupStartAction() {
        startAction?()
        startButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        startButton.backgroundColor =  UIColor(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
    }
//    private func makeDate(_ date: Date) {
//
//        let timeInterval = date.timeIntervalSince(dates)
//        
//        if timeInterval > 0 {
//            let totalSaconds = Int(timeInterval)
//            let days = totalSaconds / 86400
//            let hours = (totalSaconds % 86400) / 3600
//            let minutes = (totalSaconds % 3600) / 60
//            let seconds = totalSaconds % 60
//            
//            if days > 0 {
//                timeLabel.text = String(format: "%02d дн: %02d ч", days, hours)
//            }else if hours > 0 {
//                timeLabel.text = String(format: "%02d:%02d мин",  hours, minutes)
//            }else if minutes > 0 {
//                timeLabel.text = String(format: "%02d:%02d мин",  minutes, seconds)
//            }else {
//                timeLabel.text = String(format: "00:%02d",seconds)
//            }
//        }else {
//            
//        }
//        
//    }
    override func layoutSubviews() {
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }
    
}


