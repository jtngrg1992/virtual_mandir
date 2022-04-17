//
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol InteractionsPanelListener: AnyObject {
    func interactionsPanelDidRecordInteraction(_ interaction: MandirInteraction)
}

protocol InteractionsPanelViewInteracting {
    var supportedInteractions: [MandirInteraction] { get set }
    var interactionsPerSide: Int {  get }
    var presenter: InteractionsPanelPresenting? { get set }
    var listener: InteractionsPanelListener? { get set }
    func generateInteractionButtons()
}

protocol InteractionsPanelPresenting: AnyObject {
    var interactor: InteractionsPanelViewInteracting? { get set }
    var interactionButtonTemplate: InteractionsPanelButtonInterface { get }
    func interactionButtonsUpdated(col1: [InteractionsPanelButtonInterface], col2: [InteractionsPanelButtonInterface])
}

class InteractionsPanelInteractor: InteractionsPanelViewInteracting {
    
    var supportedInteractions: [MandirInteraction] = [] {
        didSet {
            generateInteractionButtons()
        }
    }
    
    var interactionsPerSide: Int {
        return 2
    }
    
    weak var presenter: InteractionsPanelPresenting?
    
    weak var listener: InteractionsPanelListener?
    
    init(supportedInteractions: [MandirInteraction]) {
        self.supportedInteractions = supportedInteractions
        generateInteractionButtons()
    }
    
    @objc func handleInteractionButtonTap(_ sender: InteractionsPanelButton) {
        listener?.interactionsPanelDidRecordInteraction(sender.interaction)
    }
    
    func generateInteractionButtons() {
        guard let delegate = presenter else {
            return
        }
        let interactionButtons: [InteractionsPanelButtonInterface] = supportedInteractions.map { interaction in
            let button = delegate.interactionButtonTemplate
            button.interaction = interaction
            button.setContent(title: interaction.interactionLocalizedTitle, image: interaction.interactionThumbnail)
            button.addTarget(self, action: #selector(handleInteractionButtonTap(_:)), for: .valueChanged)
            return button
        }
        
        // section these buttons into multiple columns
        let chunkedInteractions = interactionButtons.chunked(into: 2)
        
        var columnOneInteractions: [InteractionsPanelButtonInterface] = []
        var columnTwoInteractions: [InteractionsPanelButtonInterface] = []
        
        if chunkedInteractions.count > 0 {
            columnOneInteractions = chunkedInteractions.first!
        }
        
        if chunkedInteractions.count > 1 {
            columnTwoInteractions = chunkedInteractions[1]
        }
        
        delegate.interactionButtonsUpdated(col1: columnOneInteractions, col2: columnTwoInteractions)
    }
}
