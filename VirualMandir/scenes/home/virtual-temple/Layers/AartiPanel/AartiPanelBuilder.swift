//
//  ArtiPanelBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 17/04/22.
//

import Foundation

class AartiPanelBuilder {
    static func build(withListener listener: AartiPanelListener?) -> AartiPanelViewing {
        let view: AartiPanelViewing = AartiPanelView()
        let interactor: AartiPanelInteracting = AartiPanelInteractor()
        interactor.listener = listener
        view.interactor = interactor
        interactor.presenter = view
        return view
    }
}
