import UIKit

public extension RxCollectionView {
    
    public func set(cellSize size: CGSize) -> RxCollectionView {
        self.cellSize = size
        return self
    }
    
    public func set(cellWidth width: Int, andHeight height: Int) -> RxCollectionView {
        self.cellSize = CGSize(width: width, height: height)
        return self
    }
    
    public func set(edgeInsets insets: UIEdgeInsets) -> RxCollectionView {
        self.edgeInsets = insets
        return self
    }
    
    public func set(edgeInsetsForEmptyDataSet insets: UIEdgeInsets) -> RxCollectionView {
        self.edgeInsetsForEmpty = insets
        return self
    }
    
    public func set(shouldCenterCellWithOneElement should: Bool) -> RxCollectionView {
        self.centerWithOneElement = should
        return self
    }
}
