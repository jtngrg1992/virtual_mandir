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
            God(id: 1,
                name: "Lord Hanuman",
                image: UIImage(named: "hanuman")!,
                artiMusic: .hanumanChalisa),
            God(id: 2,
                name: "Lord Shiva",
                image: UIImage(named: "shiva")!,
                artiMusic: .shankarArti)
        ]
        
        view.backgroundColor = .white
        let v = VirtualTempleViewBuilder.build(withGods: gods)
        v.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(v)
        view.pinTopEdge(v, considerSafeArea: false)
        view.pinBottomEdge(v, considerSafeArea: false)
        view.pinHorizontally(v)
    }


}

