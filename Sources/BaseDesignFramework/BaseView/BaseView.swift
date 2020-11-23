//
//  BaseView.swift
//  
//
//  Created by manjil on 11/23/20.
//

import UIKit

open class BaseView: UIView {
    
    /// The freeze view
    private lazy var freezerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createDesign()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func createDesign() {
        backgroundColor = .white
    }
    
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
    
    
    public func freezeAll() {
        
        addSubview(freezerView)
        
        NSLayoutConstraint.activate([
            freezerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            freezerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            freezerView.topAnchor.constraint(equalTo: topAnchor),
            freezerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    /// This method will remove the freezer view from screen
    public func unFreezeAll() {
        freezerView.removeConstraints(freezerView.constraints)
        freezerView.removeFromSuperview()
    }
}
