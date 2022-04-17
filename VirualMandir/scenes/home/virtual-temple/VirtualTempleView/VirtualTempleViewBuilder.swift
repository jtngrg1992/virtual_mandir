//
//  VirtualTempleViewBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

class VirtualTempleViewBuilder {
    static func build(withGods gods: [God]) -> VirtualTempleViewing {
        let interactor: VirtualTempleInteracting = VirtualTempleInteractor(gods: gods)
        let virtualTemple: VirtualTempleViewing = VirtualTempleView(frame: .zero)
        interactor.presenter = virtualTemple
        virtualTemple.interactor = interactor
        return virtualTemple
    }
}
