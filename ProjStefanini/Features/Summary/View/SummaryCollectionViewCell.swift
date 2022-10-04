//
//  SummaryCollectionViewCell.swift
//  ProjStefanini
//
//  Created by user228425 on 10/3/22.
//

import UIKit

extension SummaryCollectionViewCell {
    struct Config {
        let image: UIImage
        
        init(image: UIImage) {
            self.image = image
        }
    }
}

final class SummaryCollectionViewCell: UICollectionViewCell {
    static let identifier = "summaryCell"
    private lazy var imageView: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isOpaque = true

        return image
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = UIImage()
    }
    
    func setCell(with config: Config) {
        self.imageView.image = config.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SummaryCollectionViewCell {
    private func layoutViews() {
        contentView.addSubview(imageView)
        imageViewConstraints()
    }
    
    private func imageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
