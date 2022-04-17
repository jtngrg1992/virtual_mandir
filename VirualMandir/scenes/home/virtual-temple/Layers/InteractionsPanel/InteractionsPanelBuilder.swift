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
        var interactor: InteractionsPanelViewInteracting = InteractionsPanelInteractor(supportedInteractions: interactions)
        interactor.delegate = view
        view.interactor = interactor
        return view
    }
}
