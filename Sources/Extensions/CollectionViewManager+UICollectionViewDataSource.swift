//
//  CollectionViewManager+UICollectionViewDataSource.swift
//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit.UICollectionView

extension CollectionViewManager: UICollectionViewDataSource {
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _sectionItems[section].cellItems.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellItem = self.cellItem(for: indexPath)!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellItem.reuseType.identifier, for: indexPath)
        cellItem.configure(cell)
        return cell
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _sectionItems.count
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewItem = self.viewItem(for: indexPath) else {
            return UICollectionReusableView()
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: viewItem.type.kind,
                                                                   withReuseIdentifier: viewItem.identifier,
                                                                   for: indexPath)
        viewItem.configure(view)
        return view
    }
    
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return cellItem(for: indexPath)?.canMove(at: indexPath) ?? false
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             moveItemAt sourceIndexPath: IndexPath,
                             to destinationIndexPath: IndexPath) {
        guard let sourceSectionItem = self.sectionItem(for: sourceIndexPath),
              let destinationIndexPathSectionItem = self.sectionItem(for: destinationIndexPath) else {
            return
        }
        let cellItem = sourceSectionItem.cellItems.remove(at: sourceIndexPath.row)
        destinationIndexPathSectionItem.cellItems.insert(cellItem, at: destinationIndexPath.row)
        moveItemsHandler?(collectionView, sourceIndexPath, destinationIndexPath)
    }
}
