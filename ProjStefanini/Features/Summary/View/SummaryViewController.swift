//
//  SummaryViewController.swift
//  ProjStefanini
//
//  Created by user228425 on 10/3/22.
//

import UIKit

class SummaryViewController: UIViewController {
    private lazy var mainView: SummaryMainView = {
        var view = SummaryMainView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var presenter: SummaryPresenter = {
        var presenter = SummaryPresenter(view: self)
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutViews()
    }
}

//MARK: - LayoutView
extension SummaryViewController {
    private func layoutViews() {
        view.addSubview(mainView)
        mainViewConstraints()
    }
    
    private func mainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SummaryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.identifier, for: indexPath) as? SummaryCollectionViewCell else { return UICollectionViewCell() }
        
        let config = SummaryCollectionViewCell.Config(
            image: presenter.getImage(at: indexPath.row)
        )
        
        cell.setCell(with: config)
        return cell
    }
}

extension SummaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}

extension SummaryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        LoadingStatus.showUniversalLoadingView(
            true,
            loadingText: "Procurando..."
        )
        presenter.fetchGallery(from: text)
    }
}

extension SummaryViewController: SummaryPresenterDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.mainView.reloadCollectionView()
        }
    }
}
