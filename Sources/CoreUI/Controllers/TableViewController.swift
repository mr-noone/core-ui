import UIKit
import RouteKit
import DiffKit

open class TableViewController<SectionItem: Equatable, View: UITableView, Router: RouterProtocol>: BaseTableViewController<View, Router> {
  public typealias SectionSet = DiffKit.SectionSet<SectionItem, AnyHashable, AnyHashable>
  
  // MARK: - Properties
  
  public private(set) var models = SectionSet()
  
  private lazy var queue = DispatchQueue(label: String(describing: self))
  private lazy var mainQueue = DispatchQueue.main
  
  // MARK: - Inits
  
  public override init(style: UITableView.Style) {
    super.init(style: style)
  }
  
  // MARK: - Methods
  
  public func setModels(_ newModels: SectionSet, shouldReload: Bool = true, animated: Bool = true) {
    guard isViewLoaded, shouldReload else {
      models = newModels
      return
    }
    
    queue.async { [weak self] in
      guard let self = self else { return }
      
      let diff = self.models.diff(from: newModels)
      if self.models.isEmpty {
        self.models.apply(diff: diff)
        self.mainQueue.sync { self.mainView.reloadData() }
      } else {
        self.models.apply(diff: diff)
        self.mainQueue.sync {
          self.mainView.apply(diff: diff, with: animated ? .fade : .none)
        }
      }
    }
  }
  
  // MARK: - UITableViewDataSource
  
  open override func numberOfSections(in tableView: UITableView) -> Int {
    return models.countOfSections
  }
  
  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.countOfItems(in: section)
  }
  
  open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return models[section].header as? String
  }
  
  open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return models[section].footer as? String
  }
}
