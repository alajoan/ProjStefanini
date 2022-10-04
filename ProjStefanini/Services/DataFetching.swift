//
//  DataFetching.swift
//  ProjStefanini
//
//  Created by Admin on 19/10/21.
//

import Foundation
import Alamofire
import AlamofireImage

class DataFetching {
    
    static func fetchGallery(_ nameSearched: String, completionHandler: @escaping([GalleryData]) -> Void){
        
        let cleanURL = Utils.cleanURL(URL: nameSearched)
        
        var galleries: [GalleryData] = []
        var galleryFiltered: [GalleryData] = []
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 1ceddedc03a5d71",
        ]
        
        let url = "https://api.imgur.com/3/gallery/search/top/top/0?q=\(cleanURL)"
        
        let request = AF.request(url, headers: headers)
        
        request.responseJSON { (response) in
            
            switch response.result {
            
            case .success:
                do {
                    galleries.removeAll()
                    guard
                        let response = response.data
                    else { return }
                    let gallery = try JSONDecoder().decode(Gallery.self, from: response)
                    galleries.append(contentsOf: gallery.data)
                    galleries.forEach { image in
                        if image.images?[0].link != "" {
                            galleryFiltered.append(image)
                        }
                    }
                    completionHandler(galleryFiltered)
                    LoadingStatus.showUniversalLoadingView(false)
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                break
                
            case .failure(let error):
                print("Deu erro: \(error.localizedDescription) \(String(describing: error.failedStringEncoding))")
                break
            }
            
        }
    }
    
    static func fetchImage(URL: String, completionHandler: @escaping(UIImage) -> Void) {
        AF.request(URL).responseImage { response in
            switch response.result {
            case .success(let image):
                let size = CGSize(width: 70, height: 70)
                let aspectScaledToFitImage = image.af.imageAspectScaled(toFit: size)
                completionHandler(aspectScaledToFitImage)
            case .failure(_):
                completionHandler(UIImage(named: "UnavailableImage") ?? UIImage())
            }
        }
    }
}
