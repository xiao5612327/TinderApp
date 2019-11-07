//
//  RegistrationViewModel.swift
//  Tinber
//
//  Created by Xiaoping Weng on 11/6/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var fullName: String? { didSet { checkFormValidity() }}
    var email: String? { didSet { checkFormValidity() }}
    var password: String? { didSet { checkFormValidity() }}
    
    fileprivate func checkFormValidity() {
        let isForValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        
        isFormValidObserver?(isForValid)
    }
    
    // Reactive programming
    
    var isFormValidObserver: ((Bool) -> ())?
}
