//
//  ViewController.swift
//  Tinber
//
//  Created by xiaoping on 8/23/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {
    
    let cardsDeckView = UIView()
    let bottomControls = HomeBttomControlStackView()
    let topStackView = HomeTopControlStackView()
    
    var cardViewModel = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        
        bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        setupLayout()
        setupFirestoreUserCards()
        fetchUserFromFirebase()
    }
    
    @objc fileprivate func handleRefresh() {
        fetchUserFromFirebase()
    }
    
    var lastfetchedUser: User?
    
    fileprivate func fetchUserFromFirebase() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Fetching Users"
        hud.show(in: view)
        
        // will introduce pagination here to page through 2 users at a time
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastfetchedUser?.uid ?? ""]).limit(to: 1)
        
        query.getDocuments { (snapshot, error) in
            hud.dismiss()
            if let err = error {
                print("failed to fetch  Users: ", err)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModel.append(user.toCardViewModel())
                self.lastfetchedUser = user
                
                self.setupCardFromUser(user: user)
            })
        }
    }
    
    fileprivate func setupCardFromUser(user: User) {
        let cardView = CardView(frame: .zero)
        cardView.cardViewModel = user.toCardViewModel()
        cardsDeckView.addSubview(cardView)
        cardsDeckView.sendSubviewToBack(cardView)
        cardView.fillSuperview()
    }
    
    @objc func handleSetting() {
        
        let settingsController = SettingsController()
        let naviControler = UINavigationController(rootViewController: settingsController)
        present(naviControler, animated: true, completion: nil)
    }

    fileprivate func setupFirestoreUserCards() {

        cardViewModel.forEach { (card) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = card
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }

    }

    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomControls])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.bringSubviewToFront(cardsDeckView)
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
    }
}

