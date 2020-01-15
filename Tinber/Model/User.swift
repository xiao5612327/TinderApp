//
//  User.swift
//  Tinber
//
//  Created by xiaoping on 10/7/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import Foundation
import UIKit

struct User: produceCardViewModel {
    
    var name: String
    var age: Int
    var profession: String
    var imageName: [UIImage]
    
//    init(dictionary: [String: Any]) {
//         // we will initial user here
//        let name = dictionary["fullName"]
//        
//        
//    }
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .regular)]))

        return CardViewModel(imageNames: imageName, attributedString: attributedText, textAlignment: .left)
    }
}
