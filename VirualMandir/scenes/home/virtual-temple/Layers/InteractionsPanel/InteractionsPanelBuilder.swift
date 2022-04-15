//
//  InteractionsPanelBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import Foundation

class InteractionsPanelBuilder {
    static func build(withInteractions interactions: [MandirInteraction]) -> InteractionsPanelViewing {
        let view: InteractionsPanelViewing = InteractionsPanelView()
        var viewmodel: InteractionsPanelViewModelling = InteractionsPanelViewModel(supportedInteractions: interactions)
        viewmodel.delegate = view
        view.viewModel = viewmodel
        return view
    }
}
