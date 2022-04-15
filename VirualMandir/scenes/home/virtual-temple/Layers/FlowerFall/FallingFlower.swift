//
//  FallingFlower.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 15/04/22.
//

import UIKit

protocol FallingFlowering {
    var scale: CGFloat { get set }
    var scaleRange: CGFloat { get set }
    var image: UIImage { get set }
}

struct FallingFlower: FallingFlowering {
    public var scale: CGFloat
    public var scaleRange: CGFloat
    public var image: UIImage
}
