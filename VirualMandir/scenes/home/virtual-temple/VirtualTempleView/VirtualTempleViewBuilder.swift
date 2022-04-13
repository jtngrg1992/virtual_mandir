//
//  VirtualTempleViewBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

class VirtualTempleViewBuilder {
    static func build(withGods gods: [God]) -> VirtualTempleViewing {
        let viewModel: VirtualTempleViewModeling = VirtualTempleViewModel(gods: gods)
        let virtualTemple: VirtualTempleViewing = VirtualTempleView(frame: .zero)
        virtualTemple.viewModel = viewModel
        return virtualTemple
    }
}
