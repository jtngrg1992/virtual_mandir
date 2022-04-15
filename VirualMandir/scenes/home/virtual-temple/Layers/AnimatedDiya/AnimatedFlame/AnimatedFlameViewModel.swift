//
//  AnimatedFlameViewModel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol AnimatedFlameViewModelling {
    var flameAssetName: String { get set }
    var flameFrameRate: Int { get set }
    var separator: String { get set }
    var flameFrames: [UIImage] { get }
}

class AnimatedFlameViewModel: AnimatedFlameViewModelling {
    public var flameAssetName: String
    public var flameFrameRate: Int
    public var separator: String
    
    public var flameFrames: [UIImage] {
        let assetNames: [String] = Array(1...flameFrameRate).map { "\(flameAssetName)\(separator)\($0)"}
        let assets: [UIImage] = assetNames.compactMap { UIImage(named: $0) }
        return assets
    }
    
    init(flameAssetName: String, flameFrameRate: Int, separator: String) {
        self.flameFrameRate = flameFrameRate
        self.flameAssetName = flameAssetName
        self.separator = separator
    }
}
