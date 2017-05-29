import UIKit

public extension RxCollectionView {
    
    public func customise <Cell: UICollectionViewCell, Model> (cellForReuseIdentifier identifier: String,
                           _ callback: @escaping (IndexPath, Cell, Model) -> Void) -> RxCollectionView {
        
        return customise(cellForReuseIdentifier: identifier,
                         withNibName: nil,
                         andType: Cell.self,
                         representedByModelOfType: Model.self,
                         customisedBy: callback)
    }
    
    public func customise <Cell: UICollectionViewCell, Model> (cellForReuseIdentifier identifier: String,
                           withNibName nibName: String,
                           _ callback: @escaping (IndexPath, Cell, Model) -> Void) -> RxCollectionView {
        
        return customise(cellForReuseIdentifier: identifier,
                         withNibName: nibName,
                         andType: Cell.self,
                         representedByModelOfType: Model.self,
                         customisedBy: callback)
    }
    
    private func customise <Cell: UICollectionViewCell, Model> (cellForReuseIdentifier identifier: String,
                            withNibName nibName: String?,
                            andType cellType: Cell.Type,
                            representedByModelOfType modelType: Model.Type,
                            customisedBy callback: @escaping (IndexPath, Cell, Model) -> Void) -> RxCollectionView {
        
        if let nib = nibName {
            collectionView?.register(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: identifier)
        }
        
        var row = RxCell()
        row.identifier = identifier
        row.customise = { i, cell, model in
            if let c = cell as? Cell, let m = model as? Model  {
                callback (i, c, m)
            }
        }
        
        let key = String(describing: modelType)
        modelToRow[key] = row
        
        return self
    }
    
}
