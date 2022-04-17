//
//  GodsCarousel.swift
//  VirtualMandir
//
//  Created by Jatin Garg on 13/04/22.
//

import UIKit

protocol GodsCarouselViewing: GodsCarouselPresenter, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, VirtualMandirLayer {
    func setGods(_ gods: [God])
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
    
    public var interactor: GodsCarouselInteracting! {
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func setup() {
        addSubview(collectionView)
        pinVertically(collectionView)
        pinHorizontally(collectionView)
    }
    
    func setGods(_ gods: [God]) {
        interactor.setGods(gods)
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
        return interactor.godCount
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
            cell.god = try interactor.god(atIndex: indexPath.item)
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        interactor.handleDisplay(ofItemAtIndex: indexPath.item)
    }
}

extension GodsCarouselView {
    func layoutYourselfOutInContainer() {
        superview?.pinVertically(self)
        superview?.pinHorizontally(self)
    }
}
