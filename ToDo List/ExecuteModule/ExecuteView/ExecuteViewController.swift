//
//  ExecuteViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 10.09.2024.
//

import UIKit

protocol ExecuteViewControllerProtocol: AnyObject {
    func success()
}

class ExecuteViewController: UIViewController {

    var presenter: ExecutePresenterProtocol!
    private var executeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Выполняю"
        view.backgroundColor = UIColor(red: 0.9294117647, green: 0.9568627451, blue: 0.9490196078, alpha: 1)
        createCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("--------")
        presenter.getFetch()
        executeCollectionView.reloadData()
    }

    //    MARK: UICollectionView
    private func createCollectionView() {
        executeCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        executeCollectionView.register(ExecuteCollectionViewCell.self, forCellWithReuseIdentifier: "ExecuteCollectionViewCell.self")
     
        executeCollectionView.register(HeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        
        executeCollectionView.delegate = self
        executeCollectionView.dataSource = self
        view.addSubview(executeCollectionView)
        executeCollectionView.backgroundColor = .clear
        executeCollectionView.frame = view.frame

    }
}

extension ExecuteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.arrayModels?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExecuteCollectionViewCell.self", for: indexPath) as? ExecuteCollectionViewCell else { return UICollectionViewCell()}
        
        guard let model = presenter.arrayModels?[indexPath.item] else { return UICollectionViewCell() }
        cell.makeModel(model)
        cell.removeActionClouser = {
            self.presenter.getRemove(model: model)
            self.presenter.getFetch()
            self.executeCollectionView.reloadData()
        }
        return cell
        
    }
}

extension ExecuteViewController: ExecuteViewControllerProtocol {
    func success() {
        executeCollectionView.reloadData()
    }
}
extension ExecuteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = presenter.arrayModels?[indexPath.item]else { return  }
        let taskVC = Builder.createTaskView(model) {
            self.presenter.getRemove(model: model)
            self.presenter.getFetch()
            self.executeCollectionView.reloadData()
        }
        self.present(taskVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height2 = (100 / (932 / 100)) * (view.bounds.height / 100)
        let width = (400 / (430 / 100)) * (view.bounds.width / 100)
        return CGSize(width: width, height: height2)
    }
}
