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
}
