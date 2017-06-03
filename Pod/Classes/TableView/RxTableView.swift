import UIKit
import RxSwift
import RxCocoa

public class RxTableView: NSObject,
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate {
    
    let kDEFAULT_REUSE_ID = "RxTableView_ID"
    let kDEFAULT_ROW_HEIGHT: CGFloat = 44
    
    var table: UITableView?
    
    var estimatedRowHeight: CGFloat?
    var modelToRow: [String : RxRow] = [:]
    var clicks: [String : (IndexPath, Any) -> Void] = [:]
    var modelToCanEdit: [String: (IndexPath, Any) -> Bool] = [:]
    var modelToCommitEdit: [String: (IndexPath, UITableViewCellEditingStyle, Any) -> Void] = [:]
    var reachEnd: (() -> Void)?
    
    private var data: [Any] = []
    
    override init () {
        // do nothing
    }
    
    init (table: UITableView) {
        self.table = table
    }
    
    public static func create () -> RxTableView {
        return RxTableView ()
    }
    
    public func bind (toTable table: UITableView) -> RxTableView {
        self.table = table
        self.table?.estimatedRowHeight = kDEFAULT_ROW_HEIGHT
        self.table?.rowHeight = UITableViewAutomaticDimension
        return self
    }
    
    public func update (withData data: [Any])  {
        
        table?.delegate = self
        table?.dataSource = self
        
        self.data = data.filter { element -> Bool in
            let key = String(describing: type(of: element))
            return self.modelToRow[key] != nil
        }
        
        self.table?.reloadData()
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // Table View Delegate & Data Source
    ////////////////////////////////////////////////////////////////////////////
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let row = modelToRow [key]
        let height = row?.height ?? kDEFAULT_ROW_HEIGHT
        
        return height
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let row = modelToRow [key]
        
        let cellId = row?.identifier ?? kDEFAULT_REUSE_ID
        let customise = row?.customise
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        customise? (indexPath, cell, item)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let click = clicks[key]
        
        click? (indexPath, item)
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let diffY = contentHeight - scrollView.frame.size.height
        
        if offsetY >= diffY {
            reachEnd?()
        }
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let canEdit = modelToCanEdit[key]
        return (canEdit? (indexPath, item)) ?? false
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let commit = modelToCommitEdit[key]
        commit? (indexPath, editingStyle, item)
    }
}

struct RxRow  {
    var identifier: String?
    var height: CGFloat?
    var customise: ((IndexPath, UITableViewCell, Any) -> Void)?
    var canEdit: Bool = false
}
