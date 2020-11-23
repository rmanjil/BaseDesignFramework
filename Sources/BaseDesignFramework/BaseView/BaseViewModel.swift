//
//  BaseViewModel.swift
//  
//
//  Created by manjil on 11/23/20.
//

import Foundation
import Combine

@available(iOS 13.0, *)
open class BaseViewModel{
    
    public let trigger = PassthroughSubject<AppRoutable,Never>()
    public var bag = Set<AnyCancellable>()
    
    public init() {
        
    }
    
    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}

