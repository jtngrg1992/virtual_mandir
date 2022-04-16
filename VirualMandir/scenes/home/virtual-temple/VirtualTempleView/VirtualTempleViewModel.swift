//
//  VirtualTempleViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

protocol VirtualTempleViewModeling: InteractionsPanelModuleDelegate {
    var gods: [God] { get set }
}

class VirtualTempleViewModel: VirtualTempleViewModeling {
    var gods: [God]
    
    
    init(gods: [God]) {
        self.gods = gods
    }
}

extension VirtualTempleViewModel {
    func interactionsPanelDidRecordInteraction(_ interaction: MandirInteraction) {
        print(interaction)
    }
}
