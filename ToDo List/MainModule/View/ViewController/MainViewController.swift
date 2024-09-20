//
//  ViewController.swift
//  ToDo List
//
//  Created by Macbook pro on 30.07.2024.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func success()
    func failure(error: Error)
}


class MainViewController: UIViewController {

    public var mainPresenterProtocol: MainPresenterProtocol!
    public var notification: (() -> Void)?
    public var reloadDataComlection: (() -> Void)?
    private var mainCollectionView: UICollectionView!
    private var mainDate = Date()
    
    private var arraySection = ["На Сегодня",  "На этой недели", "На следующей недели", "Больше двух недель"]
    private let arrayColorSection: [UIColor] = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.9294117647, green: 0.9568627451, blue: 0.9490196078, alpha: 1)
        createCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainPresenterProtocol.getFetch()
        mainCollectionView.reloadData()
    }
  
    //    MARK: UICollectionView
    private func createCollectionView() {
        mainCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell.self")
        mainCollectionView.register(MainCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MainCollectionReusableView")
        mainCollectionView.register(HeaderView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        view.addSubview(mainCollectionView)
        mainCollectionView.backgroundColor = .clear
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        mainCollectionView.contentInsetAdjustmentBehavior = .automatic
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 5),
            mainCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height - 100)
        ])
    }

}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mainPresenterProtocol.mainModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainPresenterProtocol.mainModels?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell.self", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell()}
        guard let model = mainPresenterProtocol.mainModels?[indexPath.section][indexPath.item] else { return UICollectionViewCell() }
        cell.makeModel(model)
        cell.startAction = {
            if model.pausa  {
                self.mainPresenterProtocol.getDelete(model)
                self.mainPresenterProtocol.getFetch()
                collectionView.reloadData()
            }else {
                self.mainPresenterProtocol.update(main: model, isStarted: true)
            }
        }
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let titleSection = arraySection[indexPath.section]
        let colorSection = arrayColorSection[indexPath.section]
        if indexPath.section == 0 {
            let reusabl = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MainCollectionReusableView", for: indexPath) as! MainCollectionReusableView
            reusabl.getSection(title: titleSection, color: colorSection)
            return reusabl
        }else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: HeaderView.reuseIdentifier,for: indexPath) as! HeaderView
            headerView.getTitle(title: titleSection, color: colorSection)
            return headerView
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = mainPresenterProtocol.mainModels?[indexPath.section][indexPath.item] else { return  }
        let taskVC = Builder.createTaskView(model) {
            self.mainPresenterProtocol.getDelete(model)
            self.mainPresenterProtocol.getFetch()
            self.mainCollectionView.reloadData()
        }
        self.present(taskVC, animated: true)
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height1 = (260 / (932 / 100)) * (view.bounds.height / 100)
        let height2 = (80 / (932 / 100)) * (view.bounds.height / 100)
        let width = (400 / (430 / 100)) * (view.bounds.width / 100)
        switch section {
        case 0:
            return CGSize(width: width, height: height1)
        default:
            return CGSize(width: width, height: height2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height2 = (100 / (932 / 100)) * (view.bounds.height / 100)
        let width = (400 / (430 / 100)) * (view.bounds.width / 100)
        return CGSize(width: width, height: height2)
    }
    
}



// MARK: MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func success() {
        mainCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}

