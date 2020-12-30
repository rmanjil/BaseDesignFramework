//
//  BaseCoordinator.swift
//  
//
//  Created by manjil on 11/23/20.
//

import UIKit

public protocol Coordinator: class {
    func start(with deepLink: DeepLink?)
}

open class BaseCoordinator: NSObject, Coordinator {
    // Private property to hold refrence to child coordinators
    private(set) var childCoordinators: [Coordinator] = []
    
    // Closure to indicate a coordinator has been removed
    var coordinatorRemoved: (() -> Void)?
    
    // When a coordinator is removed
    private var onRemove: (() -> Void)?
    
    // When a coordinator is finished
    public var onFinish: (() -> Void)?
    
    //public initializer
    public override init(){}
    
    /// Method to start the coordinator with deeplink
    ///
    /// - Parameter deepLink: the deepLink
    open func start(with deepLink: DeepLink?) {}
    
    /// This method will add the child coordinator that are currently coordinating
    ///
    /// - Parameter coordinator: the coordinator
    private func addChild(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator}) else { return } //child coordinator is already coordinating check
        childCoordinators.append(coordinator)
    }
    
    /// Method to remove child coordinator. This method will remove all the child coordinators of the provided coordinator as well
    ///
    /// - Parameter coordinator: the coordinator to remove
    private func removeChild(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator as? BaseCoordinator else { return } //if we have child coordinators and the provided coordinator is not nil
        // Remove all childs of coordinator
        if !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeChild($0) })
        }
        
        // Remove the coordinator itself
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
        
        // set that the coordinator was removed
        coordinatorRemoved?()
    }
    
    /// This method will add new coordinator and start it
    ///
    /// - Parameter coordinator: the coordinator to start
    public func coordinate(to coordinator: BaseCoordinator, deepLink: DeepLink? = nil) {
        addChild(coordinator)
        coordinator.onRemove = { [unowned self, unowned coordinator] in
            self.removeChild(coordinator)
        }
        coordinator.start(with: deepLink)
    }
    
    /// Method to complete the opertaion of a coordinator
    public func finish() {
        onRemove?()
        onFinish?()
    }
    
    public func removeOnly() {
        onRemove?()
    }

    /// returns child coordinator of type C if it exists. else return nil
    /// - Parameter type: class of type Coordinator
    public func getChild<C>(type: C.Type) -> C? {
        for coordinator in getChildrens() {
            if let requiredCoordinator = coordinator as? C {
                return requiredCoordinator
            }
        }
        return nil
    }
    
    /// returns all child coordinators
    /// - Returns: child coordinators
    public func getChildrens() -> [Coordinator] {
        return childCoordinators
    }
    
    
    public func removeAllChild() {
        childCoordinators.removeAll()
    }
    deinit {
        print("Deinit ->", String(describing: self))
    }
}
