import UIKit
import RouteKit

open class BaseTableViewController<View: UITableView, Router: RouterProtocol>: ScrollViewController<View, Router>, UITableViewDataSource, UITableViewDelegate {
  // MARK: - Properties
  
  private let style: UITableView.Style!
  
  // MARK: - Inits
  
  public init(style: UITableView.Style) {
    self.style = style
    super.init()
  }
  
  public override convenience init() {
    self.init(style: .plain)
  }
  
  // MARK: - View lifecycle
  
  open override func loadMainView() -> View {
    return View(frame: .zero, style: style)
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    mainView.separatorInset.left = 16
    mainView.dataSource = self
    mainView.delegate = self
  }
  
  // MARK: - UITableViewDataSource
  
  open func numberOfSections(in tableView: UITableView) -> Int {
    fatalError("numberOfSections(in:) has not been implemented")
  }
  
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    fatalError("tableView(_:numberOfRowsInSection:) has not been implemented")
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    fatalError("tableView(_:cellForRowAt:) has not been implemented")
  }
  
  open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return nil
  }
  
  open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return nil
  }
  
  // MARK: - UITableViewDelegate
  
  open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
  open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return nil
  }
  
  open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return nil
  }
  
  open func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    return nil
  }
}
