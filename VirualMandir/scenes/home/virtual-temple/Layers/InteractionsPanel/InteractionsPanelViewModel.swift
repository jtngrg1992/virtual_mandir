//
//  InteractionsPanelViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

enum MandirInteraction {
    case lightDiya
    case offerFlowers
    case playShankh
    case ringBell
}

extension MandirInteraction {
    var interactionLocalizedTitle: String {
        switch self {
        case .lightDiya:
            return Strings.lightDiya.getLocalizedString(forLanguage: .hindi)
        case .offerFlowers:
            return Strings.offerFlowers.getLocalizedString(forLanguage: .hindi)
        case .playShankh:
            return Strings.playShankh.getLocalizedString(forLanguage: .hindi)
        case .ringBell:
            return Strings.ringBell.getLocalizedString(forLanguage: .hindi)
        }
    }
    
    var interactionThumbnail: UIImage? {
        var imageName: String = ""
        switch self {
        case .lightDiya:
            imageName = "diya_thumb"
        case .offerFlowers:
            imageName = "flower_thumb"
        case .playShankh:
            imageName = "shankh_thumb"
        case .ringBell:
            imageName = "bell_thumb"
        }
        return UIImage(named: imageName)
    }
}

protocol InteractionsPanelModuleDelegate: AnyObject {
    func interactionsPanelDidRecordInteraction(_ interaction: MandirInteraction)
}

protocol InteractionsPanelViewModelling {
    var supportedInteractions: [MandirInteraction] { get set }
    var interactionsPerSide: Int {  get }
    var delegate: InteractionsPanelViewModelDelegate? { get set }
    var moduleDelegate: InteractionsPanelModuleDelegate? { get set }
    func generateInteractionButtons()
}

protocol InteractionsPanelViewModelDelegate: AnyObject {
    var interactionButtonTemplate: InteractionsPanelButtonInterface { get }
    func viewModelDidUpdateInteractionButtons(col1: [InteractionsPanelButtonInterface], col2: [InteractionsPanelButtonInterface])
}

class InteractionsPanelViewModel: InteractionsPanelViewModelling {
    
    var supportedInteractions: [MandirInteraction] = [] {
        didSet {
            generateInteractionButtons()
        }
    }
    
    var interactionsPerSide: Int {
        return 2
    }
    
    weak var delegate: InteractionsPanelViewModelDelegate?
    
    weak var moduleDelegate: InteractionsPanelModuleDelegate?
    
    init(supportedInteractions: [MandirInteraction]) {
        self.supportedInteractions = supportedInteractions
        generateInteractionButtons()
    }
    
    @objc func handleInteractionButtonTap(_ sender: InteractionsPanelButton) {
        moduleDelegate?.interactionsPanelDidRecordInteraction(sender.interaction)
    }
    
    func generateInteractionButtons() {
        guard let delegate = delegate else {
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
    
        delegate.viewModelDidUpdateInteractionButtons(col1: columnOneInteractions, col2: columnTwoInteractions)
    }
}
