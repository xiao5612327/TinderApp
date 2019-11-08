//
//  Bindable.swift
//  Tinber
//
//  Created by Xiaoping Weng on 11/7/19.
//  Copyright © 2019 Xiaoping. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
}
