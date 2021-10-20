//
//  DetailViewController.swift
//  ProjStefanini
//
//  Created by Admin on 20/10/21.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    var image: UIImage?
    var titles: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = image
        detailTitle.text = titles
    }
}
