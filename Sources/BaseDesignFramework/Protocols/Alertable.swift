//
//  Alertable.swift
//  
//
//  Created by manjil on 11/23/20.
//

import UIKit

public protocol Alertable {
    var title: String { get }
    var style: UIAlertAction.Style { get }
    var tag: Int { get }
}
