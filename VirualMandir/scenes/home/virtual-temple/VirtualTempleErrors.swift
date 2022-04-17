//
//  VirtualTempleErrors.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

enum VirtualTempleError: Error {
    case noGodFoundAtIndex
    case interactorNotInitialized(String)
    case collectionViewCellNotRegistered(String)
}


extension VirtualTempleError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noGodFoundAtIndex:
            return "No God Found at specified index."
        case .interactorNotInitialized(let interactorName):
            return "You forgot to initialize the interactor - \(interactorName)"
        case .collectionViewCellNotRegistered(let cellName):
            return "You forgot to register the collectionview cell: \(cellName)"
        }
    }
}
