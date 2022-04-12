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
        
        view.backgroundColor = .red
        
        let gods = [
            God(id: 1, name: "Lord Hanuman", image: UIImage(named: "hanuman")!),
            God(id: 1, name: "Lord Hanuman", image: UIImage(named: "hanuman")!)
        ]
        
        let v = GodsCarouselBuilder.build(withGods: gods)
        
        v.frame = CGRect(origin: CGPoint(x: 10, y: 100), size: CGSize(width: UIScreen.main
                                                                        .bounds.width, height: 200))
        view.addSubview(v)
    }


}

