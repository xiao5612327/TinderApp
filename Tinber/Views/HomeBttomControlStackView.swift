//
//  HomeBttomControlStackView.swift
//  Tinber
//
//  Created by xiaoping on 8/23/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit

class HomeBttomControlStackView: UIStackView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "dismiss"))
    let superLikeButton = createButton(image: #imageLiteral(resourceName: "super_like"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "like"))
    let specialButton = createButton(image: #imageLiteral(resourceName: "boot"))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true

        // bottom
        let bottomSubViews = [refreshButton, dislikeButton, superLikeButton, likeButton, specialButton]
        bottomSubViews.forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
