//
//  VirtualTempleErrors.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

enum VirtualTempleError: Error {
    case noGodFoundAtIndex
    case viewModelNotInitialized(String)
    case collectionViewCellNotRegistered(String)
}


extension VirtualTempleError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noGodFoundAtIndex:
            return "No God Found at specified index."
        case .viewModelNotInitialized(let vmName):
            return "You forgot to initialize viewmodel - \(vmName)"
        case .collectionViewCellNotRegistered(let cellName):
            return "You forgot to register the collectionview cell: \(cellName)"
        }
    }
}
