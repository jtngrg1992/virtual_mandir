//
//  InteractionsPanelView.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit


protocol InteractionsPanelViewing: VirtualMandirLayer, InteractionsPanelViewModelDelegate {
    var viewModel: InteractionsPanelViewModelling? { get set }
    func setModuleDelegate(_ moduleDelegate: InteractionsPanelModuleDelegate?)
    func animateInteractionButton(forInteraction interaction: MandirInteraction, forDuration duration: TimeInterval)
}

class InteractionsPanelView: View, InteractionsPanelViewing {
    
    var viewModel: InteractionsPanelViewModelling? {
        willSet {
            if viewModel == nil && newValue != nil {
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
    
    private var leftStack: UIStackView!
    private var rightStack: UIStackView!
    private var interactionButtons: [InteractionsPanelButtonInterface] = []
    
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
    
    func setModuleDelegate(_ moduleDelegate: InteractionsPanelModuleDelegate?) {
        viewModel?.moduleDelegate = moduleDelegate
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


extension InteractionsPanelView {
    func viewModelDidUpdateInteractionButtons(col1: [InteractionsPanelButtonInterface], col2: [InteractionsPanelButtonInterface]) {
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
