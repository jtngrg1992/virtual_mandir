//
//  ViewController.swift
//  VirualMandir
//
//  Created by Jatin Garg on 11/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gods = [
            God(id: 1, name: "Lord Hanuman", image: UIImage(named: "hanuman")!),
            God(id: 1, name: "Lord Hanuman", image: UIImage(named: "hanuman")!)
        ]
        
        let v = VirtualTempleViewBuilder.build(withGods: gods)
        v.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(v)
        view.pinTopEdge(v, considerSafeArea: false)
        view.pinBottomEdge(v, considerSafeArea: false)
        view.pinHorizontally(v)
        
        let v2 = InteractionsPanelButton()
        v2.frame = CGRect(origin: CGPoint(x: 10, y: 200), size: CGSize(width: 80, height: 80))
        v2.setContent(title: "Test Title", image: UIImage(named: "shankh_thumb"))
        view.addSubview(v2)
    }


}

