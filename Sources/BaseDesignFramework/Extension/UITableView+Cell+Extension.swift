//
//  File.swift
//  
//
//  Created by manjil on 12/2/20.
//

import UIKit

public extension UIView {
    static var identifier: String {
        "\(self)"
    }
}


public extension UITableView {
    public func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass.identifier))
    }
    
    public func dequeueCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(String(describing: T.self))")
        }
        return cell
    }
}

