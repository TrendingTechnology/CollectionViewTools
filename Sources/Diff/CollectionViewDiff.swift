//
//  Copyright © 2019 Rosberry. All rights reserved.
//

/// A type that allows you to implement your own diff algorithm.
public protocol CollectionViewDiff {

    /// This function returns array of CollectionViewChange.
    ///
    /// - Parameters:
    ///   - old: Old items.
    ///   - new: New items.
    func changes<T: DiffItem>(old: [T], new: [T]) -> [CollectionViewChange<T>]
}
