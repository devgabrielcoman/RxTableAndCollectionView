import UIKit

public extension RxCollectionView {
    
    public func customise <Cell: UICollectionViewCell> (cellForEmptyDataWithIdentifier identifier: String,
                                                        _ callback: @escaping (IndexPath, Cell, CellEmptyModel) -> Void) -> RxCollectionView {
        
        return self.customise(cellForEmptyDataWithIdentifier: identifier,
                              withNibName: nil,
                              andType: Cell.self,
                              callback)
    }
    
    public func customise <Cell: UICollectionViewCell> (cellForEmptyDataWithIdentifier identifier: String,
                                                        withNibName nibName: String?,
                                                        _ callback: @escaping (IndexPath, Cell, CellEmptyModel) -> Void) -> RxCollectionView {
        
        return self.customise(cellForEmptyDataWithIdentifier: identifier,
                              withNibName: nibName,
                              andType: Cell.self,
                              callback)
    }
    
    func customise <Cell: UICollectionViewCell> (cellForEmptyDataWithIdentifier identifier: String,
                                                withNibName nibName: String?,
                                                andType cellType: Cell.Type,
                                                _ callback: @escaping (IndexPath, Cell, CellEmptyModel) -> Void) -> RxCollectionView {
        
        return self.customise(cellForReuseIdentifier: identifier,
                              withNibName: nibName,
                              andType: cellType,
                              representedByModelOfType: CellEmptyModel.self,
                              customisedBy: callback)
    }
    
}

