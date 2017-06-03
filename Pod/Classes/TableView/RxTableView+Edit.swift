import UIKit

extension RxTableView {
    
    public func can <Model> (editRowWithReuseIdentifier identifier: String,
                            _ callback: @escaping (IndexPath, Model) -> Bool) -> RxTableView {
        
        
        let key = String(describing: Model.self)
        modelToCanEdit[key] = { index, model in
            if let m = model as? Model {
                return callback (index, m)
            } else {
                return false
            }
        }
        
        return self
    }
    
    public func commit <Model> (editForRowWithReuseIdentifier identifier: String,
                        _ callback: @escaping (IndexPath, UITableViewCellEditingStyle, Model) -> Void) -> RxTableView {
        
        
        let key = String(describing: Model.self)
        modelToCommitEdit[key] = { index, style, model in
            if let m = model as? Model {
                callback(index, style, m)
            }
        }
        
        return self
    }
    
}
