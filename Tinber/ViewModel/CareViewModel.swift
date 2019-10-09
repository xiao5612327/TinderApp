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

struct CardViewModel {
    
    let imageNames: [UIImage]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
}


