import UIKit

public extension RxCollectionView {
    
    public func did <Model> (clickOnCellWithReuseIdentifier identifier: String,
                     _ action: @escaping (IndexPath, Model) -> Void) -> RxCollectionView {
        
        let key = String(describing: Model.self)
        clicks[key] = { index, model in
            if let m = model as? Model {
                action (index, m)
            }
        }
        
        return self
    }
    
    public func did (reachEnd action: @escaping () -> Void) -> RxCollectionView {
        reachEnd = action
        return self
    }
    
}
