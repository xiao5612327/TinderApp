//
//  Advertiser.swift
//  Tinber
//
//  Created by xiaoping on 10/9/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import Foundation
import UIKit

struct Advertiser: produceCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageNames: [posterPhotoName], attributedString: attributedString, textAlignment: .center)
    }
}
