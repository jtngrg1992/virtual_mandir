//
//  GodsCarouselBuilder.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import Foundation


class GodsCarouselBuilder {
    static func build(withGods gods: [God]) -> GodsCarouselViewing {
        let view: GodsCarouselViewing = GodsCarouselView(frame: .zero)
        let viewModel: GodsCarouselViewModeling = GodsCarouselViewModel(delegate: view)
        viewModel.setGods(gods)
        view.viewModel = viewModel
        return view
    }
}
