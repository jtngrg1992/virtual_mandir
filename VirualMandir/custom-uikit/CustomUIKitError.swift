//
//  CustomUIKitError.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

enum CustomUIKitError: Error {
    case initCoderNotImplemented
}

extension CustomUIKitError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .initCoderNotImplemented:
            return "init(coder:) not implemented. Please lay down your view programatically inside the setup() function"
        }
    }
}
