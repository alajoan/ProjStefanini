//
//  SummaryMainView.swift
//  ProjStefanini
//
//  Created by user228425 on 10/3/22.
//

import UIKit

final class SummaryMainView: UIView {
    
    private lazy var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Procure por imagens"
        return title
    }()
    
    private lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Digite algo para pesquisar imagens."
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            SummaryCollectionViewCell.self,
            forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    init(delegate: SummaryViewController) {
        super.init(frame: .zero)
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        searchBar.delegate = delegate
        layoutViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

//MARK: - Layout
extension SummaryMainView {
    private func layoutViews() {
        addSubview(title)
        addSubview(searchBar)
        addSubview(collectionView)
        
        titleConstraints()
        searchBarConstraints()
        collectionViewConstraints()
    }
    
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            title.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            title.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    private func searchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: title.bottomAnchor,
                constant: 20
            ),
            searchBar.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            searchBar.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    private func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: 20
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            )
        ])
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let margin: CGFloat = 10
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        return flowLayout
    }
}
