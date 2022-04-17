//
//  GodsCarouselViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation


protocol GodsCarouselListener {
    func godsCarouselDidScroll(toGod god: God)
}

protocol GodsCarouselInteracting {
    var gods: [God] { get set }
    var godCount: Int { get }
    var listener: GodsCarouselListener? { get set }
    
    func god(atIndex index: Int) throws -> God
    func setGods(_ gods: [God])
    func handleDisplay(ofItemAtIndex index: Int)
}

protocol GodsCarouselPresenter: AnyObject {
    var interactor: GodsCarouselInteracting! { get set }
    func didLoadGods()
}

class GodsCarouselInteractor: GodsCarouselInteracting {
    internal var gods: [God]
    var godCount: Int { gods.count }
    weak var delegate: GodsCarouselPresenter?
    var listener: GodsCarouselListener?
    
    
    init(delegate: GodsCarouselPresenter, listener: GodsCarouselListener?) {
        self.gods = []
        self.delegate = delegate
        self.listener = listener
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
    
    func handleDisplay(ofItemAtIndex index: Int) {
        guard let god = try? god(atIndex: index) else {
            return
        }
        listener?.godsCarouselDidScroll(toGod: god)
    }
    
    
}
