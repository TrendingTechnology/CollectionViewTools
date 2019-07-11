//
//  CollectionViewReusableViewItem.swift
//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit.UICollectionView

public enum ReusableViewType {
    case header
    case footer

    public var kind: String {
        switch self {
        case .header:
            return UICollectionView.elementKindSectionHeader
        case .footer:
            return UICollectionView.elementKindSectionFooter
        }
    }
}

public protocol CollectionViewReusableViewItem {

    var type: ReusableViewType { get set }

    func size(for collectionView: UICollectionView, with layout: UICollectionViewLayout) -> CGSize
    func view(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView
    func register(for collectionView: UICollectionView)
}
