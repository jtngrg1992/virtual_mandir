//
//  GodsCarousel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

class GodsCarouselView: View {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.dataSource = self
        c.delegate = self
        c.register(GodsCarouselCollectionViewCell.self, forCellWithReuseIdentifier: GodsCarouselCollectionViewCell.reuseID)
        return c
    }()
    
    public var viewModel: GodsCarouselViewModeling?
    
    override func setup() {
        addSubview(collectionView)
        pinVertically(collectionView)
        pinHorizontally(collectionView)
    }
}

extension GodsCarouselView: GodsCarouselViewModelDelegate {
    func didLoadGods() {
        collectionView.reloadData()
    }
}

extension GodsCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard
            let godCount = viewModel?.godCount
        else {
            return 0
        }
        return godCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GodsCarouselCollectionViewCell.reuseID, for: indexPath) as? GodsCarouselCollectionViewCell else {
            fatalError(VirtualTempleError
                        .collectionViewCellNotRegistered(String(describing: GodsCarouselCollectionViewCell.self))
                        .localizedDescription)
        }
        
        do {
            cell.god = try viewModel?.god(atIndex: indexPath.item)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        
        return cell
    }
}
