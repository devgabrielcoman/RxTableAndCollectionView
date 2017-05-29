import UIKit

public extension RxTableView {
    
    public func set(estimatedRowHeight height: CGFloat) -> RxTableView {
        
        estimatedRowHeight = height
        
        if let h = estimatedRowHeight, let table = table {
            table.estimatedRowHeight = h
            table.rowHeight = UITableViewAutomaticDimension
        }
        
        return self
    }
    
}
