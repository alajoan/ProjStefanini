//
//  Summary.swift
//  ProjStefanini
//
//  Created by user228425 on 10/3/22.
//

import Foundation
struct Gallery: Decodable {
    var data: [GalleryData]
    
    init(data: [GalleryData]) {
        self.data = data
    }
}

struct GalleryData: Decodable {
    var images: [GalleryImages]?
    var title: String
    
    init(images: [GalleryImages] = [GalleryImages](), title: String = "") {
        self.images = images
        self.title = title
    }
}

struct GalleryImages: Decodable {
    var link: String
    
    init(link: String = "") {
        self.link = link
    }
}
