//
//  Strings.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import Foundation

enum Strings {
    case playShankh
    case lightDiya
    case ringBell
    case offerFlowers
    case playAarti
    case pauseAarti
    case noAudioFile
    case technicalFailure
}

extension Strings {
    func getLocalizedString(forLanguage language: SystemLanguage) -> String {
        switch language {
        case .hindi:
            switch self {
            case .lightDiya:
                return "दिया जलाएं"
            case .offerFlowers:
                return "फूल चढ़ाएं"
            case .playShankh:
                return "शंख बजाएं"
            case .ringBell:
                return "घंटी बजाएं"
            case .playAarti:
                return "आरती चलाएं।"
            case .pauseAarti:
                return "आरती रोकें।"
            case .noAudioFile:
                return "ध्वनि उपलब्ध नहीं है।"
            case .technicalFailure:
                return "तकनीकी बाधा के कारन यह करना संभव नहीं होगा। "
            }
        }
    }
}
