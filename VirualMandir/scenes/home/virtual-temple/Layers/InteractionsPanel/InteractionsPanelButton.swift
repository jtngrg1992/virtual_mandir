//
//  InteractionsPanelButton.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol InteractionsPanelButtonInterface: InteractiveButton {
    var interaction: MandirInteraction! { get set }
    func setContent(title: String?, image: UIImage?)
}

class InteractionsPanelButton: InteractiveButton, InteractionsPanelButtonInterface {
    var interaction: MandirInteraction!
    
    final var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var titleLabel: UILabel = {
        let lable = UILabel()
        lable.lineBreakMode = .byWordWrapping
        lable.numberOfLines = 2
        lable.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        lable.textColor = .white
        return lable
    }()
    
    final var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    var imageWidthConstraint: NSLayoutConstraint!
    var imageHeightConstriant: NSLayoutConstraint!
    
    override func setup() {
        super.setup()
        
        addSubview(contentStack)
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(titleLabel)
        
        pinLeadingEdge(contentStack, constant: -10)
        pinTrailingEdge(contentStack, constant: 10)
        contentStack.centerVerticallyInContainer()
        
        imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        imageWidthConstraint.isActive = true
        
        imageHeightConstriant = imageView.heightAnchor.constraint(equalToConstant: 0)
        imageHeightConstriant.isActive = true
        
        backgroundColor = .black.withAlphaComponent(0.5)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageWidthConstraint.constant = bounds.width * 0.5
        imageHeightConstriant.constant = bounds.width * 0.5
    }
    
    func setContent(title: String?, image: UIImage?) {
        imageView.image = image
        titleLabel.text = title
    }
}
