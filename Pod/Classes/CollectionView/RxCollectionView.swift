import UIKit
import RxSwift
import RxCocoa

public class RxCollectionView: NSObject,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UIScrollViewDelegate {
    
    let kDEFAULT_REUSE_ID = "RxCollectionView_ID"
    let kDEFAULT_CELL_SIZE = CGSize(width: 50, height: 50)
    let kDEFAULT_EDGE_INSETS = UIEdgeInsetsMake(0, 0, 0, 0)
    
    var collectionView: UICollectionView?
    
    var modelToRow: [String : RxCell] = [:]
    var clicks: [String : (IndexPath, Any) -> Void] = [:]
    var sizes: [String : (IndexPath, Any) -> CGSize] = [:]
    var insets: ((Int) -> UIEdgeInsets)?
    
    var reachEnd: (() -> Void)?
    
    private var data: [Any] = []

    override init () {
        // do nothing
    }
    
    init (collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    public static func create() -> RxCollectionView {
        return RxCollectionView()
    }
    
    public func bind (toCollection collection: UICollectionView) -> RxCollectionView {
        self.collectionView = collection
        return self
    }
    
    public func update (withData data: [Any])  {
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        self.data = data.filter { element -> Bool in
            let key = String(describing: type(of: element))
            return self.modelToRow[key] != nil
        }
        
        self.collectionView?.reloadData()
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // Collection View Delegate, Data Source & Scroll View
    ////////////////////////////////////////////////////////////////////////////
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let row = modelToRow [key]
        
        let cellId = row?.identifier ?? kDEFAULT_REUSE_ID
        let customise = row?.customise
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        customise? (indexPath, cell, item)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let size = sizes[key]
        return size? (indexPath, item) ?? kDEFAULT_CELL_SIZE
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        let key = String(describing: type(of: item))
        let click = clicks[key]
        click? (indexPath, item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets? (section) ?? kDEFAULT_EDGE_INSETS
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x,
        offsetY = scrollView.contentOffset.y
        let contentWidth = scrollView.contentSize.width,
        contentHeight = scrollView.contentSize.height
        let diffX = contentWidth - scrollView.frame.size.width,
        diffY = contentHeight - scrollView.frame.size.height
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let direction = layout.scrollDirection
            
            if direction == .horizontal && offsetX >= diffX {
                reachEnd?()
            }
            if direction == .vertical && offsetY >= diffY {
                reachEnd?()
            }
        }
    }
}

struct RxCell  {
    var identifier: String?
    var customise: ((IndexPath, UICollectionViewCell, Any) -> Void)?
}
