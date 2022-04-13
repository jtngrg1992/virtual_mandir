//
//  GodsCarouselViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation


protocol GodsCarouselViewModeling {
    var gods: [God] { get set }
    var godCount: Int { get }
    
    func god(atIndex index: Int) throws -> God
    func setGods(_ gods: [God])
}

protocol GodsCarouselViewModelDelegate: AnyObject {
    func didLoadGods()
}

class GodsCarouselViewModel: GodsCarouselViewModeling {
    internal var gods: [God]
    public var godCount: Int { gods.count }
    public weak var delegate: GodsCarouselViewModelDelegate?
    
    init(delegate: GodsCarouselViewModelDelegate) {
        self.gods = []
        self.delegate = delegate
    }
    
    public func god(atIndex index: Int) throws -> God {
        guard gods.indices.contains(index) else {
            throw VirtualTempleError.noGodFoundAtIndex
        }
        return gods[index]
    }
    
    func setGods(_ gods: [God]) {
        self.gods = gods
        self.delegate?.didLoadGods()
    }
}
