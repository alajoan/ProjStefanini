//
//  SummaryPresenter.swift
//  ProjStefanini
//
//  Created by user228425 on 10/3/22.
//

import Foundation
import UIKit

protocol SummaryPresenterDelegate {
    func reloadCollectionView()
}

final class SummaryPresenter {
    private var galleryUrls: [String]?
    private var galleryImages: [UIImage] = [UIImage]()
    private var view: SummaryPresenterDelegate?
    
    var numberOfItems = 0
    
    init(view: SummaryPresenterDelegate){
        self.view = view
    }

    func fetchGallery(from text: String) {
        galleryUrls = nil
        galleryImages = []
        DataFetching.fetchGallery(text, completionHandler: { [weak self] gallery in
            guard let self = self else { return }
            LoadingStatus.showUniversalLoadingView(false)
            var filteredUrls = [String]()
            gallery.forEach { gallery in
                if gallery.images?[0].link != nil {
                    filteredUrls.append(gallery.images?[0].link ?? "")
                }
            }
            self.galleryUrls = filteredUrls
            self.numberOfItems = filteredUrls.count
            self.fetchImages()
        })
    }
    
    func fetchImages(){
        guard let gallery = galleryUrls else { return }
        
        for index in 0..<gallery.count {
            DataFetching.fetchImage(URL: gallery[index], completionHandler: { [weak self] images in
                guard let self = self else { return }
                self.galleryImages.append(images)
                self.view?.reloadCollectionView()
            })
        }
    }
    
    func getImage(at index: Int) -> UIImage {
        guard let galleryImages = galleryImages[safe: index] else { return UIImage() }
        return galleryImages
    }
}
