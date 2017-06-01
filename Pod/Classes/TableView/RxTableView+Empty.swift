import UIKit

public extension RxTableView {
    
    public func customise <Row: UITableViewCell> (rowForEmptyDataWithIdentifier identifier: String,
                                                 _ callback: @escaping (IndexPath, Row, RowEmptyModel) -> Void) -> RxTableView {
        
        return self.customise(rowForEmptyDataWithIdentifier: identifier,
                              withNibName: nil,
                              andType: Row.self,
                              callback)
    }
    
    public func customise <Row: UITableViewCell> (rowForEmptyDataWithIdentifier identifier: String,
                                                  withNibName nibName: String?,
                                                  _ callback: @escaping (IndexPath, Row, RowEmptyModel) -> Void) -> RxTableView {
        
        return self.customise(rowForEmptyDataWithIdentifier: identifier,
                              withNibName: nibName,
                              andType: Row.self,
                              callback)
    }
    
    func customise <Row: UITableViewCell> (rowForEmptyDataWithIdentifier identifier: String,
                                           withNibName nibName: String?,
                                           andType rowType: Row.Type,
                                           _ callback: @escaping (IndexPath, Row, RowEmptyModel) -> Void) -> RxTableView {
        
        return self.customise(rowForReuseIdentifier: identifier,
                              withNibName: nibName,
                              andType: rowType,
                              andHeight: nil,
                              representedByModelOfType: RowEmptyModel.self,
                              customisedBy: callback)
    }
}

