//
//  VirtualMandirLayer.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 17/04/22.
//

import Foundation

protocol VirtualMandirLayer: View {
    var isAnimating: Bool { get }
    func layoutYourselfOutInContainer()
    func startAnimating()
    func stopAnimating()
}

extension VirtualMandirLayer {
    var isAnimating: Bool {
        false
    }
    
    func startAnimating() {}
    func stopAnimating() {}
}
