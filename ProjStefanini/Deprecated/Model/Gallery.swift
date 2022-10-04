//
//  Gallery.swift
//  ProjStefanini
//
//  Created by Admin on 19/10/21.
//

import Foundation

struct Gallerys: Codable {
    var data: [GalleryDatas]?
}

struct GalleryDatas: Codable {
    var images: [GalleryImagess]?
    var title: String?
}

struct GalleryImagess: Codable {
    var link: String?
}
