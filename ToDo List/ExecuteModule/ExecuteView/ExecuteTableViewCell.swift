//
//  ExecuteTableViewCell.swift
//  ToDo List
//
//  Created by Macbook pro on 19.09.2024.
//

import UIKit

class ExecuteTableViewCell: UITableViewCell {

    
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let startButton = UIButton()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let radius = contentView.frame.height / 3.33
        contentView.backgroundColor = .white
                contentView.layer.cornerRadius = radius
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        setupView()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupView() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.layer.cornerRadius = mainImage.frame.width / 4
        contentView.addSubview(mainImage)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)

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
            
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            startButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            startButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
        ])
    }
    
    public func makeModel(_ main: MainModel) {
        mainImage.image = UIImage(named: "\(main.image)")
        titleLabel.text = main.title
    }
    
    override func layoutSubviews() {
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }
   

    

}
