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
    
    var name: String?
    var age: Int?
    var profession: String?
//    var imageName: [String]
    var imageUrl1: String?
    var uid: String?
    
    init(dictionary: [String: Any]) {
         // we will initial user here
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        self.name = dictionary["fullName"] as? String ?? ""
        self.imageUrl1 = dictionary["imageUrl1"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        let ageString = age != nil ? "\(age!)" : "N\\A"
        
        attributedText.append(NSAttributedString(string: "  \(ageString)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        let professionString = profession != nil ? profession! : "Not available"
        attributedText.append(NSAttributedString(string: "\n\(professionString)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .regular)]))

        return CardViewModel(imageNames: [imageUrl1 ?? ""], attributedString: attributedText, textAlignment: .left)
    }
}
