//
//  GodsCarousel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

protocol GodsCarouselViewing: View, GodsCarouselViewModelDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var viewModel: GodsCarouselViewModeling? { get set }
}

class GodsCarouselView: View, GodsCarouselViewing {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.dataSource = self
        c.delegate = self
        c.register(GodsCarouselCollectionViewCell.self, forCellWithReuseIdentifier: GodsCarouselCollectionViewCell.reuseID)
        c.isPagingEnabled = true
        c.bounces = false
        c.showsHorizontalScrollIndicator = false
        return c
    }()
    
    public var viewModel: GodsCarouselViewModeling? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func setup() {
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension GodsCarouselView {
    func didLoadGods() {
        collectionView.reloadData()
    }
}

extension GodsCarouselView {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard
            let godCount = viewModel?.godCount
        else {
            return 0
        }
        return godCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
