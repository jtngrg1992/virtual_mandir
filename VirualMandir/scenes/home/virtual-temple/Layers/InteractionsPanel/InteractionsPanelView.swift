//
//  InteractionsPanelView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit


protocol InteractionsPanelViewing: VirtualMandirLayer, InteractionsPanelPresenting {
    func setListener(_ moduleDelegate: InteractionsPanelListener?)
    func animateInteractionButton(forInteraction interaction: MandirInteraction, forDuration duration: TimeInterval)
}


/*
    This is a dumb layer that displays all the mandir interactions (except Aarti playback)
    in a single view. The interactions can be found inside MandirInteractions enum.
    This has been coded in such a manner that adding any future interactions is extremly easy.
 */

class InteractionsPanelView: View, InteractionsPanelViewing {
    var interactor: InteractionsPanelViewInteracting? {
        willSet {
            if interactor == nil && newValue != nil {
                newValue?.generateInteractionButtons()
            }
        }
    }
    
    var interactionButtonTemplate: InteractionsPanelButtonInterface {
        let b: InteractionsPanelButtonInterface = InteractionsPanelButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }
    
    private var stackTemplate: UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 30
        return stack
    }
    
    private var leftStack: UIStackView! // contains all the interactions on left side of the mandir
    private var rightStack: UIStackView! // contains all the interactions on right side of the mandir
    
    private var interactionButtons: [InteractionsPanelButtonInterface] = [] // an array containing instances of all interaction buttons
    
    override func setup() {
        leftStack = stackTemplate
        rightStack = stackTemplate
        
        addSubview(leftStack)
        addSubview(rightStack)
        
        pinLeadingEdge(leftStack)
        pinTrailingEdge(rightStack)
        pinBottomEdge(leftStack, considerSafeArea: false)
        pinBottomEdge(rightStack, considerSafeArea: false)
    }
    
    private func populate(stack: UIStackView, withInteractions interactions: [InteractionsPanelButtonInterface]) {
        
        interactions.forEach {
            interactionButtons.append($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.constraintWidth(to: 80)
            $0.constraintHeight(to: 80)
            stack.addArrangedSubview($0)
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // this will ensure that the layer doesn't prevent user from scrolling between Gods
        var result: Bool = false
        
        for button in interactionButtons {
            let absoluteFrame = button.convert(button.bounds, to: self)
            
            if absoluteFrame.contains(point){
                result = true
                break
            }
        }
        return result
    }
    
    func setListener(_ moduleDelegate: InteractionsPanelListener?) {
        interactor?.listener = moduleDelegate
    }
    
    func animateInteractionButton(forInteraction interaction: MandirInteraction, forDuration duration: TimeInterval) {
        guard
            let targetButton = interactionButtons.first(where: { $0.interaction == interaction })
        else {
            return
        }
        targetButton.animateProgress(withDuration: duration)
    }
}

// MARK: Presenter & View Methods
extension InteractionsPanelView {
    func interactionButtonsUpdated(col1: [InteractionsPanelButtonInterface], col2: [InteractionsPanelButtonInterface]) {
        interactionButtons = []
        if !col1.isEmpty {
            populate(stack: leftStack, withInteractions: col1)
        }
        
        if !col2.isEmpty {
            populate(stack: rightStack, withInteractions: col2)
        }
    }
    
    func layoutYourselfOutInContainer() {
        guard let superview = superview else {
            return
        }
        superview.pinLeadingEdge(self, constant: -10)
        superview.pinTrailingEdge(self, constant: 10)
        superview.pinBottomEdge(self, considerSafeArea: true, constant: 50)
        heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.5).isActive = true
    }
}
