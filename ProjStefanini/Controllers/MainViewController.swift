//
//  MainViewController.swift
//  ProjStefanini
//
//  Created by Admin on 19/10/21.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    
    let margin: CGFloat = 10
    var gallery: [GalleryData] = []
    var images: [UIImage] = []
    var selectedImage: UIImage?
    var selectedTitle: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextfield.delegate = self
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        guard let collectionView = mainCollectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextfield.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        LoadingStatus.showUniversalLoadingView(true, loadingText: "Searching....")
        //gallery = presenter.GetGallery
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textField.text != "" ? true : false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let galleryImage = gallery[indexPath.item]
        
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as! MainCollectionViewCell
        
        //cell.setCell(image: galleryImage.images?[0] ?? GalleryImages())
        cell.title = gallery[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = mainCollectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
        selectedImage = cell.image.image
        selectedTitle = cell.title
        performSegue(withIdentifier: "ShowingDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowingDetail" {
            if let destinationVc = segue.destination as? DetailViewController {
                destinationVc.image = selectedImage
                destinationVc.titles = selectedTitle
            }
        } else {
            return
        }
    }
}
