import UIKit

open class BaseViewController: UIViewController {
  // MARK: - View lifecycle
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DispatchQueue.main.async {
      self.navigationController?.navigationBar.sizeToFit()
    }
  }
}
