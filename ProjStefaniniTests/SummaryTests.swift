//
//  SummaryTests.swift
//  ProjStefaniniTests
//
//  Created by user228425 on 10/4/22.
//

import XCTest

class SummaryTests: XCTestCase {
    func testSummary_ShouldPassIfGalleryDataIsValid() {
        let gallery = [
            GalleryData(
                images: [
                    GalleryImages(link: "https://www.google.com")
                ],
                title: "Cat Image"
            ),
            GalleryData(
                images: [
                    GalleryImages(link: "https://www.imgur.com")
                ],
                title: "Apple Image"
            )
        ]
        
        let instance = Gallery(data: gallery)
        
        XCTAssertTrue(
            isDataValid(instance),
            "The article should`ve returned true but returned false because it was empty"
        )
    }
    
    func testSummary_ShoulPassIfGalleryDataIsNotValid() {
        let gallery = [GalleryData]()
        
        let instance = Gallery(data: gallery)
        
        XCTAssertFalse(
            isDataValid(instance),
            "The article should`ve returned false but returned false because it was not empty"
        )
    }
    
    func testSummary_ShouldPassIfImageIsValid() {
        let galleryImage = [
            GalleryImages(link: "https://www.imgur.com"),
            GalleryImages(link: "https://www.google.com")
        ]
        
        XCTAssertTrue(
            isImageValid(galleryImage),
            "Should have returned true but returned false"
        )
    }
    
    func testSummary_ShouldPassIfImageIsNotValid() {
        let galleryImage = [GalleryImages]()
        
        XCTAssertFalse(
            isImageValid(galleryImage),
            "Should have returned true but returned false"
        )
    }
    
    func testSummary_ShoudlPassIfLinkIsValid() {
        let link = GalleryImages(link: "https://github.com")
        XCTAssertTrue(
            isLinkValid(link),
            "the link is invalid, try to see if it has https and .com"
        )
    }
    
    func testSummary_ShoudlPassIfLinkIsNotValid() {
        let link = GalleryImages(link: "https://github")
        XCTAssertFalse(
            isLinkValid(link),
            "the link is valid, but should return invalid"
        )
    }    
}

//MARK: - Validation funcs
extension SummaryTests {
    func isDataValid(_ instance: Gallery) -> Bool {
        return !instance.data.isEmpty
    }
    
    func isImageValid(_ instance: [GalleryImages]) -> Bool {
        return !instance.isEmpty
    }
    
    func isLinkValid(_ link: GalleryImages) -> Bool {
        return link.link.contains("https://") && link.link.contains(".com")
    }
}
