//
//  ViewController.swift
//  Tinber
//
//  Created by xiaoping on 8/23/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    let cardsDeckView = UIView()
    let bottomStackView = HomeBttomControlStackView()
    let topStackView = HomeTopControlStackView()
    
//    let users = [User(name: "Kelly", age: 1, profession: "Music DJ", imageName: UIImage(named: "follower")), User(name: "Jen", age: 3, profession: "Lady for see", imageName: UIImage(named: "fire"))]
    
//    let cardViewModel: [CardViewModel] = {
//
//        let producer = [User(name: "Kelly", age: 1, profession: "Music DJ", imageName: [UIImage(named: "follower")!]),
//                        User(name: "Jen", age: 3, profession: "Lady for see", imageName: [UIImage(named: "fire")!]),
//                        Advertiser(title: "Slide Out Menu", brandName: "Lets Build That App", posterPhotoName: UIImage()),
//                        User(name: "on boarding", age: 66, profession: "Jupigo", imageName: [UIImage(named: "onboarding1")!, UIImage(named: "onboarding2")!, UIImage(named: "onboarding3")!])] as [produceCardViewModel]
//
//        let results = producer.map({$0.toCardViewModel()})
//        return results
//    }()
    
    var cardViewModel = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        setupLayout()
        setupDummyCards()
        fetchUserFromFirebase()
    }
    
    fileprivate func fetchUserFromFirebase() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            if let err = error {
                print("failed to fetch  Users: ", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModel.append(user.toCardViewModel())
            })
            self.setupDummyCards()
        }
    }
    
    @objc func handleSetting() {
        
        let registrationController = RegistrationController()
        present(registrationController, animated: true, completion: nil)
    }
    
    fileprivate func setupDummyCards() {
        
        cardViewModel.forEach { (card) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = card
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }

    }

    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.bringSubviewToFront(cardsDeckView)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
    }
}

