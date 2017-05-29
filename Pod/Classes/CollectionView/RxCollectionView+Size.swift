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
        self.edgeIndsets = insets
        return self
    }
    
}
