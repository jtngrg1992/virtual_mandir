//
//  FlowerEmitterLayer.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol FlowerEmitterLaying: CAEmitterLayer {
    func addAsSublayer(to view: UIView)
    func setBirthRate(to value: Float)
}

/// this layer emits marigold and rose petals randomly from top of the screen with an acceleration of 9.8 m/s2

class FlowerEmitterLayer: CAEmitterLayer, FlowerEmitterLaying {
    private var flowerImages: [FallingFlowering] = []
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override init() {
        super.init()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError(CustomUIKitError.initCoderNotImplemented.localizedDescription)
    }
    
    private func setupLayer() {
        let marigoldFlower: FallingFlowering = FallingFlower(scale: 0.08, scaleRange: 0.05, image: UIImage(named: "marigold")!)
        let rosePetal: FallingFlowering = FallingFlower(scale: 0.2, scaleRange: 0.01, image: UIImage(named: "rose-petal")!)
        
        flowerImages = [marigoldFlower, rosePetal]
        emitterShape = .line
        emitterCells = generateEmitterCells()
    }
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells: [CAEmitterCell] = []
        
        for flower in flowerImages.compactMap({ $0 }) {
            
            let cell = CAEmitterCell()
            cell.contents = flower.image.cgImage
            cell.velocity = 100
            cell.scale = flower.scale
            cell.scaleRange = flower.scaleRange
            cell.lifetime = 10
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi/3
            cell.yAcceleration = 9.8
            cell.spinRange = 2
            cell.velocityRange = 10
            cells.append(cell)
            
        }
        
        return cells
    }
    
    public func addAsSublayer(to view: UIView) {
        view.layer.addSublayer(self)
    }
    
    public func setBirthRate(to value: Float) {
        emitterCells?.forEach { $0.birthRate = value }
        birthRate = value
    }
}
