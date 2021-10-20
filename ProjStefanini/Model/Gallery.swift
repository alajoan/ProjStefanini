//
//  Gallery.swift
//  ProjStefanini
//
//  Created by Admin on 19/10/21.
//

import Foundation

struct GalleryRoot: Codable {
    var data: [GalleryData]?
}

struct GalleryData: Codable {
    var images: [GalleryImages]?
    var title: String?
}

struct GalleryImages: Codable {
    var link: String?
}
