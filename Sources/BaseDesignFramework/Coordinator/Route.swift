//
//  Route.swift
//  
//
//  Created by manjil on 11/23/20.
//

import UIKit

final public class Route {
    public weak var rootController: UIViewController?
    
    public init(rootController: UIViewController) {
        self.rootController = rootController
    }
    
    deinit {
        print("dinit route\(self)")
        rootController = nil
    }
    
}

extension Route {
    public func setRoot(presentable: Presentable?, animate: Bool = false, hideBar: Bool = false) {
        guard let navigationController = rootController as? UINavigationController,
              let controller = presentable?.presenting else {
            assertionFailure("Please properly check that controller and navigation controller both are provided")
            return
        }
        navigationController.isNavigationBarHidden = hideBar
        navigationController.setViewControllers([controller], animated: animate)
    }
    
}

extension Route {
    public func present(presentable: Presentable?, animate: Bool = false) {
        guard let navigationController = rootController as? UINavigationController,
              let controller = presentable?.presenting else {
            assertionFailure("Please properly check that controller and navigation controller both are provided")
            return
        }
        navigationController.present(controller, animated: animate, completion: nil)
    }
    
    public func dismiss(animated: Bool = true) {
        guard let navigationController = rootController else {
            assertionFailure("Please properly check that controller and navigation controller both are provided")
            return
        }
        navigationController.dismiss(animated: animated, completion: nil)
    }
}


extension Route {
    public func push(presentable: Presentable?, animated: Bool = false) {
        guard let navigationController = rootController as? UINavigationController,
              let controller = presentable?.presenting else {
            assertionFailure("Please properly check that controller and navigation controller both are provided")
            return
        }
        navigationController.pushViewController(controller, animated: animated)
    }
    
    public func pop(animated: Bool) {
        guard let navigationController = rootController as? UINavigationController else {
            assertionFailure("Please properly check that navigation controller is present as the root of router")
            return
        }
        navigationController.popViewController(animated: animated)
    }
    
    public func popTo<T: UIViewController>(_ type: T.Type, animated: Bool = true) -> T? {
        guard let navigationController = rootController as? UINavigationController else {
            assertionFailure("Please properly check that navigation controller is present as the root of router")
            return nil
        }
        
        /// find the controller to pop to
        for controller in navigationController.viewControllers where controller is T {
            navigationController.popToViewController(controller, animated: animated)
            return controller as? T
        }
        return nil
    }
    
    public func popToRoot(animated: Bool = true) {
        guard let navigationController = rootController as? UINavigationController else {
            assertionFailure("Please properly check that navigation controller is present as the root of router")
            return
        }
        navigationController.popToRootViewController(animated: animated)
    }
}
