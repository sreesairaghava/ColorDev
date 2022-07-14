//
//  Box.swift
//  ColorDev
//
//  Created by Sree Sai Raghava Dandu on 17/06/22.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    
    //MARK: - Variables
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
    
    //Init
    init(_ value: T) {
        self.value = value
    }
    
    //MARK: - Binding
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func removeBind() {
        self.listener = nil
    }
}
