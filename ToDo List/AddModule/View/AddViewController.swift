//
//  AddViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 21.08.2024.
//

import UIKit

protocol AddViewControllerProtocol {
    func succes()
}

class AddViewController: UIViewController {

    let arrayImageIcon = ["buy", "game", "write", "work", "music"]
    private var arrayButton = [UIButton]()
    
    private lazy var addTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавь задачу"
        return label
    }()
    
    private lazy var addNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        return label
    }()
    
    private let addTextField = UITextField()
    
    private lazy var addDescriotionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        return label
    }()
    
    private let addTextView = UITextView()
    
    private lazy var addIconLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите иконку"
        return label
    }()
    
    private let addScrollView = UIScrollView()
    private lazy var addStackView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private lazy var addTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Срок"
        return label
    }()
    private let addDatePicker = UIDatePicker()
    
    private lazy var addButton: UIButton = {
        $0.backgroundColor = UIColor(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        $0.setTitle("Добавить", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor( UIColor(red: 0.8852499127, green: 0.9324403405, blue: 1, alpha: 1), for: .highlighted)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(addPlan(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
   
    var addPresenter: AddPresenterProtocol!
    
//    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createView()
        createConstreint()
        setupStackView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(param:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(param:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //    MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        addScrollView.contentSize.width = addStackView.frame.width
    }
    
//    MARK: Добавыление
    private func createView() {
        view.addSubview(addTitleLabel)
        
        view.addSubview(addNameLabel)
        
        addTextField.borderStyle = .roundedRect
        addTextField.backgroundColor = UIColor(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        addTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTextField)
        
        view.addSubview(addDescriotionLabel)
        
        addTextView.translatesAutoresizingMaskIntoConstraints = false
        addTextView.layer.cornerRadius = 10
        addTextView.font = .systemFont(ofSize: 17)
        addTextView.backgroundColor = UIColor(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        view.addSubview(addTextView)
        
        view.addSubview(addIconLabel)
        
        addScrollView.translatesAutoresizingMaskIntoConstraints = false
        addScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(addScrollView)
        
        view.addSubview(addTimeLabel)
      
        addDatePicker.translatesAutoresizingMaskIntoConstraints = false
        addDatePicker.datePickerMode = .dateAndTime
        view.addSubview(addDatePicker)
        
        view.addSubview(addButton)
    }
//    MARK: Constreint
    private func createConstreint() {
        
        NSLayoutConstraint.activate([
            addTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            addTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addNameLabel.topAnchor.constraint(equalTo: addTitleLabel.bottomAnchor, constant: 30),
            addNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            addTextField.topAnchor.constraint(equalTo: addNameLabel.bottomAnchor, constant: 10),
            addTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0568),
            
            addDescriotionLabel.topAnchor.constraint(equalTo: addTextField.bottomAnchor, constant: 30),
            addDescriotionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            addTextView.topAnchor.constraint(equalTo: addDescriotionLabel.bottomAnchor, constant: 10),
            addTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.168),
            
            addIconLabel.topAnchor.constraint(equalTo: addTextView.bottomAnchor, constant: 30),
            addIconLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            addScrollView.topAnchor.constraint(equalTo: addIconLabel.bottomAnchor, constant: 15),
            addScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),

            addTimeLabel.topAnchor.constraint(equalTo: addScrollView.bottomAnchor, constant: 30),
            addTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            addDatePicker.topAnchor.constraint(equalTo: addTimeLabel.bottomAnchor, constant: 20),
            addDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0568),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
    
    @objc func updateTextView(param: Notification) {
        
    }
    
    @objc func addPlan(sender: UIButton) {
      
    }
    
    private func setupStackView() {
        addStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addScrollView.addSubview(addStackView)
        NSLayoutConstraint.activate([
            addScrollView.heightAnchor.constraint(equalTo:  view.heightAnchor, multiplier: 0.09 * CGFloat(arrayImageIcon.count + 30))
        ])
        
        arrayImageIcon.forEach { btn in
            let button = getButtonIcon(nameIcon: btn, action: #selector(addIconAction(sender:)), tag: arrayImageIcon.firstIndex(of: btn) ?? 0)
            let views = UIView()
            
            addStackView.addArrangedSubview(views)
            addStackView.addArrangedSubview(button)
            arrayButton.append(button)
            NSLayoutConstraint.activate([
                views.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.01),
                views.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.01),
                button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
                button.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09)
            ])
        }
    }
    
    
    @objc func addIconAction(sender: UIButton) {
        arrayButton.forEach { button in
            button.layer.borderColor = UIColor.clear.cgColor
        }
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.green.cgColor
    }
    
    private func getButtonIcon(nameIcon: String, action: Selector, tag: Int) -> UIButton {
        return {
            $0.tag = tag
            $0.setBackgroundImage(UIImage(named: nameIcon), for: .normal)
            $0.addTarget(self, action: action, for: .touchUpInside)
            $0.translatesAutoresizingMaskIntoConstraints = false

            return $0
        }(UIButton())
    }

}

extension AddViewController: AddViewControllerProtocol {
    func succes() {
        
    }
    
}
