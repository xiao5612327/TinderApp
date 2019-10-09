//
//  HomeBttomControlStackView.swift
//  Tinber
//
//  Created by xiaoping on 8/23/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit

class HomeBttomControlStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true

        // bottom
        let bottomSubViews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss"), #imageLiteral(resourceName: "super_like"), #imageLiteral(resourceName: "like"), #imageLiteral(resourceName: "boot")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        bottomSubViews.forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
