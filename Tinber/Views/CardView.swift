//
//  CardView.swift
//  Tinber
//
//  Created by xiaoping on 8/23/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // Configurations
    var cardViewModel: CardViewModel! {
        didSet {
            informationLabel.attributedText = cardViewModel.attributedString
            imageView.image = cardViewModel.imageNames.first
            informationLabel.textAlignment = cardViewModel.textAlignment
            informationLabel.numberOfLines = 0
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
                barsStackView.addArrangedSubview(barView)
            }
            
            barsStackView.arrangedSubviews.first?.backgroundColor = .black
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (index, image) in
            self.imageView.image = image
            self.barsStackView.arrangedSubviews.forEach { (v) in
                v.backgroundColor = .init(white: 0, alpha: 0.1)
            }
            self.barsStackView.arrangedSubviews[index].backgroundColor = .black
        }
    }
    
    fileprivate let informationLabel = UILabel()
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "follower"))
    let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
        
        // add a gradient layer somehow
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        
        setupBarsStackView()
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8), size: CGSize(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually

    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    var imageIndex = 0
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        print("tap")
        let tapLocation = gesture.location(in: nil)
        let shouldAdvance = tapLocation.x > self.frame.width / 2 ? true : false
        
        if shouldAdvance {
            cardViewModel.advanceToNextPhoto()
        }else {
            cardViewModel.goToPreviousPhotos()
        }
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChangeStatus(gesture)
        case .ended:
            handleEnded(gesture: gesture)
        default:
            ()
        }

    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        
        let shouldDismiss = abs(gesture.translation(in: nil).x) >= 100
        print(shouldDismiss)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            if shouldDismiss {
                let xValue: CGFloat = gesture.translation(in: nil).x >= 0 ? 600 : -600
                self.frame = CGRect(x: xValue, y: 0, width: self.frame.width, height: self.frame.height)
                self.isHidden = true
            }else {
                self.transform = .identity
            }
        }) { ( _ ) in
            self.transform = .identity
            if shouldDismiss {
                self.removeFromSuperview()
            }
        }
    }
    
    fileprivate func handleChangeStatus(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: nil)

        let degrees: CGFloat = translate.x / 20
        let angle = degrees * .pi / 180

        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translate.x, y: translate.y)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
