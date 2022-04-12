//
//  View.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit


protocol CustomUIKitViewing: AnyObject {
    func setup()
}

class View: UIView, CustomUIKitViewing {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() { }
    
    required init?(coder: NSCoder) {
        fatalError(CustomUIKitError.initCoderNotImplemented.localizedDescription)
    }
    
    func addConstraint(withVisualFormatLanguage visualFormat: String, views: [String:Any]) {
        NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                       options: NSLayoutConstraint.FormatOptions(),
                                       metrics: nil,
                                       views: views)
    }
    
    func pinHorizontally(_ view: UIView) {
        addConstraint(withVisualFormatLanguage: "H:|[v0]|", views: ["v0" : view])
    }
    
    func pinVertically(_ view: UIView) {
        addConstraint(withVisualFormatLanguage: "V:|[v0]|", views: ["v0" : view])
    }
}
