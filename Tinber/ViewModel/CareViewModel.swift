//
//  CareViewModel.swift
//  Tinber
//
//  Created by xiaoping on 10/7/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import Foundation
import UIKit

protocol produceCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            
            let image = imageNames[imageIndex]
            imageIndexObserver?(imageIndex, image)
        }
    }
    
    // Reactive Programming
    var imageIndexObserver: ((Int, String) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = (imageIndex + 1) >= imageNames.count ? 0 : imageIndex + 1
    }
    
    func goToPreviousPhotos() {
        imageIndex = (imageIndex - 1) < 0 ? imageNames.count - 1 : imageIndex - 1
    }
    
}


