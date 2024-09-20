//
//  TaskViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 27.08.2024.
//

import UIKit

protocol TaskViewControllerProtocol: AnyObject {
    func success()
}
class TaskViewController: UIViewController {

    public var taskPresenter: TaskPresenterProtocol?
    var clouserDelete: (() -> Void)?
    private var timer: Timer?
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "Задача"
        return label
    }()
    
    private var iconImage = UIImageView()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let circuleView = CircularView()
    private var timeLabel: String?
    
    private lazy var taskButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "stop"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(taskAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var upDateButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "update"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(removeAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var dismisButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.8852499127, green: 0.9324403405, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor =  UIColor(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        button.setTitle("Закрыть", for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismisAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let model = taskPresenter?.model else { return }
        getData(model)
        setupElemeted()
        setupConstraint()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func taskAction(sender: UIButton) {
        clouserDelete?()
        dismiss(animated: true)
    }
    
    @objc func dismisAction(sender: UIButton) {
        dismiss(animated: true)
    }
    private func setupElemeted() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        circuleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(iconImage)
        view.addSubview(discriptionLabel)
        view.addSubview(circuleView)
        view.addSubview(taskButton)
        view.addSubview(dismisButton)
        view.addSubview(upDateButton)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 3),
            
            iconImage.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            iconImage.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 4),
            iconImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
            iconImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
            
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 15),
            nameLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 4),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
            
            discriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discriptionLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 5),
            discriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            discriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            circuleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circuleView.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: discriptionLabel.bottomAnchor, multiplier: 5),
            circuleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            circuleView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            taskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskButton.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: circuleView.bottomAnchor, multiplier: 6),
            taskButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18),
            taskButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18),

            upDateButton.centerYAnchor.constraint(equalTo: taskButton.centerYAnchor),
            upDateButton.trailingAnchor.constraint(equalTo: taskButton.leadingAnchor, constant: -20),
            upDateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.11),
            upDateButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.11),
            
            dismisButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismisButton.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: taskButton.bottomAnchor, multiplier: 5),
            dismisButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            dismisButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.11),
        ])
    }
    
    private func getData(_ model: MainModel) {
        iconImage.image = UIImage(named: model.image)
        nameLabel.text = model.title
        discriptionLabel.text = "Описание: \(model.descriptions)"
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.calculateTimeRemaining(model.time, startTime: model.timeStart)
        })
    }
    
    func calculateTimeRemaining(_ date: Date, startTime: Date) {
        
        let currentDate = Date()
        let percentCircule = CGFloat(date.timeIntervalSince(startTime))
        let timeInterval = date.timeIntervalSince(currentDate)
        let circuleProgress: CGFloat =  CGFloat(timeInterval) / (percentCircule / 100)

        if timeInterval > 0 {
            let totalSeconds = Int(timeInterval)
            let days = totalSeconds / 86400
            let hours = (totalSeconds % 86400) / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            
            if days > 0 {
                timeLabel = String(format: "%02d дн %02d ч %02d м", days, hours, minutes)
            } else if hours > 0 {
                timeLabel = String(format: "%02d:%02d", hours, minutes)
            } else if minutes > 0 {
                timeLabel = String(format: "%02d:%02d", minutes, seconds)
            } else {
                timeLabel = String(format: "00:%02d", seconds)
            }
        } else {
            clouserDelete?()
            dismiss(animated: true)
        }
        guard let times = timeLabel else { return }
        circuleView.setProgress(to: circuleProgress / 100, widtAnimation: false, textCenter: times)
    }
}

extension TaskViewController: TaskViewControllerProtocol {
    func success() {
        
    }
}
