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
        cellItem.cell = cell
        cellItem.configure(cell)
        return cell
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _sectionItems.count
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        //TODO: Add same `configure` logic as with cell items
        let reusableViewItem = sectionItem(for: indexPath)?.reusableViewItems.filter { $0.type.kind == kind }.first
        let view = reusableViewItem?.view(for: collectionView, at: indexPath)
        return view ?? UICollectionReusableView()
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
