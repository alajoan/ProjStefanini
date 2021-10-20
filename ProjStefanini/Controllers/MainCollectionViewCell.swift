//
//  MainCollectionViewCell.swift
//  ProjStefanini
//
//  Created by Admin on 19/10/21.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    var title: String?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = UIImage()
    }
    
    func setCell(image: GalleryImages) {
        DataFetching.fetchImage(URL: image.link ?? "") { (galleryImage) in
            self.image.image = galleryImage
        }
    }
    
    
}
