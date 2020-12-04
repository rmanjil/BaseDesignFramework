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
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass.identifier))
    }
    
    func dequeueCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(String(describing: T.self))")
        }
        return cell
    }
}

