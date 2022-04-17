//
//  AartiPanelView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 16/04/22.
//

import Foundation

protocol AartiPanelPresenting: AnyObject {
    var aartiButton: AartiButtonInterface { get }
    var interactor: AartiPanelInteracting! { get set }
    func updateAartiProgress(toValue value: Double)
}

protocol AartiPanelViewing: VirtualMandirLayer, AartiPanelPresenting {
    func startPlayingAarti(forGod god: God)
    func pausePlayingAarti()
}

/// This Layer Represents the Aarti button and is reponsible to playing, pausing and stopping arti corresponding to the
/// God on display.

class AartiPanelView: View, AartiPanelViewing {
    
    var aartiButton: AartiButtonInterface = {
        let button = AartiButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(artiButtonTapped), for: .valueChanged)
        return button
    }()
    
    var interactor: AartiPanelInteracting!
    
    override func setup() {
        addSubview(aartiButton)
        pinTrailingEdge(aartiButton, constant: 10)
        pinTopEdge(aartiButton, considerSafeArea: false, constant: -50)
        pinBottomEdge(aartiButton, considerSafeArea: false)
    }
    
    func layoutYourselfOutInContainer() {
        guard let superview = superview else {
            return
        }
        superview.pinTopEdge(self, considerSafeArea: true)
        superview.pinHorizontally(self)
    }
    
    func startPlayingAarti(forGod god: God) {
        interactor.playAarti(forGod: god)
    }
    
    func pausePlayingAarti() {
        interactor.pauseAarti()
    }
    
    @objc private func artiButtonTapped() {
        interactor.aartiButtonTapped()
    }
    
    func updateAartiProgress(toValue value: Double) {
        aartiButton.updateAartiProgress(to: value)
    }
}
