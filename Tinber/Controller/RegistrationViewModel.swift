//
//  RegistrationViewModel.swift
//  Tinber
//
//  Created by Xiaoping Weng on 11/6/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    // Reactive programming
    var isFormValid = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var isRegisting = Bindable<Bool>()

    var fullName: String? { didSet { checkFormValidity() }}
    var email: String? { didSet { checkFormValidity() }}
    var password: String? { didSet { checkFormValidity() }}
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let pass = password else { return }
        isRegisting.value = true
        Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            if let err = error {
                print(err)
                completion(err)
                
                return
            }
            
            print("successful register", result?.user.uid)
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping( Error? ) -> ()) {
        // ONly upload image to firebase after you authrized
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/Image/\(filename)")
        let data = self.bindableImage.value?.jpegData(compressionQuality: 0.65) ?? Data()
        ref.putData(data, metadata: nil) { (_, error) in
            if let err = error {
                completion(err)
                return
            }
            ref.downloadURL { (url, error) in
                if let err = error {
                    completion(err)
                    return
                }
                self.isRegisting.value = false
                self.saveInfoToFireStore(imageUrl: url?.absoluteString ?? "", completion: completion)
            }
        }
    }
    
    fileprivate func saveInfoToFireStore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl1" : imageUrl]
        
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let err = error {
                completion(err)
                return
            }
            
            
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isForValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValid.value = isForValid

    }
}
