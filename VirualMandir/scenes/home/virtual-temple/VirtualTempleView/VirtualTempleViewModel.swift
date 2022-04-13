//
//  VirtualTempleViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation

protocol VirtualTempleViewModeling {
    var gods: [God] { get set }
}

class VirtualTempleViewModel: VirtualTempleViewModeling {
    var gods: [God]
    
    
    init(gods: [God]) {
        self.gods = gods
    }
}
