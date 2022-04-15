//
//  InteractionsPanelButton.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol InteractionsPanelButtonInterface: InteractiveButton {
    func setContent(title: String?, image: UIImage?)
}

class InteractionsPanelButton: InteractiveButton, InteractionsPanelButtonInterface {
    private var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var titleLabel: UILabel = {
        let lable = UILabel()
        lable.lineBreakMode = .byWordWrapping
        lable.numberOfLines = 2
        lable.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lable.textColor = .white
        return lable
    }()
    
    private var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private var imageWidthConstraint: NSLayoutConstraint!
    
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
        
        backgroundColor = .black.withAlphaComponent(0.5)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageWidthConstraint.constant = bounds.width * 0.6
    }
    
    public func setContent(title: String?, image: UIImage?) {
        imageView.image = image
        titleLabel.text = title
    }
}
