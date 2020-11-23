//
//  BaseController.swift
//  
//
//  Created by manjil on 11/23/20.
//

import UIKit

open class BaseController: UIViewController {
    
    /// The baseView of controller
    public let baseView: BaseView
    
    /// The baseViewModel of controller
    public let baseViewModel: BaseViewModel
    
    /// when view is loaded
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        /// setup UI
        setupUI()
        
        /// observe events
        observeEvents()
    }
    
    /// Initializer for a controller
    /// - Parameters:
    ///   - baseView: the view associated with the controller
    ///   - baseViewModel: viewModel associated with the controller
    public init(baseView: BaseView, baseViewModel: BaseViewModel) {
        self.baseView = baseView
        self.baseViewModel = baseViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        super.loadView()
        view = baseView
    }
    
    /// setup design
    open func setupUI() {}
    
    /// observer for event
    open func observeEvents() {}
}


extension BaseController {
    
    open func alert(title: String, message: String, actions: [Alertable], style: UIAlertController.Style = .alert, titleAttribute: [NSAttributedString.Key: Any]? = nil, messageAttribute: [NSAttributedString.Key: Any]? = nil, completion: ((Alertable) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let attributes = titleAttribute {
            //attributed title
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            alertController.setValue(attributedTitle, forKey: "attributedTitle")
        }
        
        if let attributes = messageAttribute {
            // Attributed message
            let attributedMsg = NSAttributedString(string: message, attributes: attributes)
            alertController.setValue(attributedMsg, forKey: "attributedMessage")
        }
        
        actions.forEach { action in
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                completion?(action)
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: nil)
        
    }
}
