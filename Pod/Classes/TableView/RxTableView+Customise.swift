import UIKit

public extension RxTableView {
    
    public func customise <Row: UITableViewCell, Model> (rowForReuseIdentifier identifier: String,
                           _ callback: @escaping (IndexPath, Row, Model) -> Void) -> RxTableView {
        
        return customise(rowForReuseIdentifier: identifier,
                         withNibName: nil,
                         andType: Row.self,
                         andHeight: nil,
                         representedByModelOfType: Model.self,
                         customisedBy: callback)
    }
    
    public func customise <Row: UITableViewCell, Model> (rowForReuseIdentifier identifier: String,
                           andHeight height: CGFloat?,
                           _ callback: @escaping (IndexPath, Row, Model) -> Void) -> RxTableView {
        
        return customise(rowForReuseIdentifier: identifier,
                         withNibName: nil,
                         andType: Row.self,
                         andHeight: height,
                         representedByModelOfType: Model.self,
                         customisedBy: callback)
    }
    
    public func customise <Row: UITableViewCell, Model> (rowForReuseIdentifier identifier: String,
                           withNibName nibName: String?,
                           _ callback: @escaping (IndexPath, Row, Model) -> Void) -> RxTableView {
        
        return customise(rowForReuseIdentifier: identifier,
                         withNibName: nibName,
                         andType: Row.self,
                         andHeight: nil,
                         representedByModelOfType: Model.self,
                         customisedBy: callback)
    }
    
    public func customise <Row: UITableViewCell, Model> (rowForReuseIdentifier identifier: String,
                           withNibName nibName: String?,
                           andHeight height: CGFloat?,
                           _ callback: @escaping (IndexPath, Row, Model) -> Void) -> RxTableView {
        
        return customise(rowForReuseIdentifier: identifier,
                         withNibName: nibName,
                         andType: Row.self,
                         andHeight: height,
                         representedByModelOfType: Model.self,
                         customisedBy: callback)
    }
    
    private func customise <Row: UITableViewCell, Model> (rowForReuseIdentifier identifier: String,
                            withNibName nibName: String?,
                            andType rowType: Row.Type,
                            andHeight height: CGFloat?,
                            representedByModelOfType modelType: Model.Type,
                            customisedBy callback: @escaping (IndexPath, Row, Model) -> Void) -> RxTableView {
        
        if let nib = nibName {
            table?.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: identifier)
        }
        
        var row = RxRow()
        row.identifier = identifier
        row.height = height ?? (estimatedRowHeight ?? kDEFAULT_ROW_HEIGHT)
        row.customise = { i, cell, model in
            if let c = cell as? Row, let m = model as? Model  {
                callback (i, c, m)
            }
        }
        
        let key = String(describing: modelType)
        modelToRow[key] = row
        
        
        return self
    }
    
}
