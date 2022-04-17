//
//  GodsCarouselBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation


class GodsCarouselBuilder {
    static func build(withGods gods: [God], andListener listener: GodsCarouselListener?) -> GodsCarouselViewing {
        let view: GodsCarouselViewing = GodsCarouselView(frame: .zero)
        let interactor: GodsCarouselInteracting = GodsCarouselInteractor(delegate: view, listener: listener)
        interactor.setGods(gods)
        view.interactor = interactor
        return view
    }
}
