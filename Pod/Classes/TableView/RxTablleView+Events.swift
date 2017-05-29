import UIKit

public extension RxTableView {
    
    public func did <Model> (clickOnRowWithReuseIdentifier identifier: String,
                     _ action: @escaping (IndexPath, Model) -> Void) -> RxTableView {
        
        
        let key = String(describing: Model.self)
        clicks[key] = { index, model in
            if let m = model as? Model {
                action (index, m)
            }
        }
        
        return self
    }
    
    public func did (reachEnd action: @escaping () -> Void) -> RxTableView {
        reachEnd = action
        return self
    }
    
}
