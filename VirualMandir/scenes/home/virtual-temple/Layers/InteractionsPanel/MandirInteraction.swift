//
//  MandirInteraction.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 17/04/22.
//

import UIKit

enum MandirInteraction {
    case lightDiya
    case offerFlowers
    case playShankh
    case ringBell
    case playAarti
    case pauseAarti
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
        case .playAarti:
            return Strings.playAarti.getLocalizedString(forLanguage: .hindi)
        case .pauseAarti:
            return Strings.pauseAarti.getLocalizedString(forLanguage: .hindi)
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
        case .playAarti:
            imageName = "play_button"
        case .pauseAarti:
            imageName = "pause_button"
        }
        return UIImage(named: imageName)
    }
}
