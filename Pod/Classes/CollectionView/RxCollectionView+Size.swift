import UIKit

public extension RxCollectionView {
    
    public func set <Model> (sizeForCellWithReuseIdentifier identifier: String,
                             _ callback: @escaping (IndexPath, Model) -> CGSize) -> RxCollectionView {
    
        let key = String(describing: Model.self)
        sizes[key] = { index, model in
            if let m = model as? Model {
                return callback (index, m)
            } else {
                return CGSize.zero
            }
        }
        
        return self
    }
    
    public func set (edgeInsets callback: @escaping (Int) -> UIEdgeInsets) -> RxCollectionView {
        
        self.insets = callback
        
        return self
    }
}
