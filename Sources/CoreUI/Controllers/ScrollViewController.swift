import UIKit
import RouteKit

open class ScrollViewController<View: UIScrollView, Router: RouterProtocol>: ViewController<View, Router>, UIScrollViewDelegate {
  // MARK: - Inits
  
  public override init() {
    super.init()
    
    let sel = #selector(keyboardNotification(_:))
    let center = NotificationCenter.default
    center.addObserver(self, selector: sel, name: UIResponder.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: sel, name: UIResponder.keyboardWillHideNotification, object: nil)
    center.addObserver(self, selector: sel, name: UIResponder.keyboardDidShowNotification, object: nil)
    center.addObserver(self, selector: sel, name: UIResponder.keyboardDidHideNotification, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Lifecycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView.delegate = self
    mainView.delaysContentTouches = true
    mainView.alwaysBounceVertical = true
    mainView.keyboardDismissMode = .interactive
    mainView.showsHorizontalScrollIndicator = false
    mainView.showsVerticalScrollIndicator = false
  }
  
  // MARK: - Private
  
  @objc private func keyboardNotification(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    
    switch notification.name {
    case UIResponder.keyboardWillShowNotification: keyboardWillShow(userInfo)
    case UIResponder.keyboardWillHideNotification: keyboardWillHide(userInfo)
    case UIResponder.keyboardDidShowNotification: keyboardDidShow(userInfo)
    case UIResponder.keyboardDidHideNotification: keyboardDidHide(userInfo)
    default: break
    }
    
    if isViewLoaded {
      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero
      let endHeight = UIScreen.main.bounds.height - endFrame.minY
      let bottomInset = view.window?.safeAreaInsets.bottom ?? 0
      if endHeight > bottomInset {
        additionalSafeAreaInsets.bottom = endHeight - bottomInset
      } else {
        additionalSafeAreaInsets.bottom = 0
      }
    }
  }
  
  // MARK: - Keyboard notifications
  
  open func keyboardWillShow(_ userInfo: [AnyHashable : Any]) {}
  
  open func keyboardWillHide(_ userInfo: [AnyHashable : Any]) {}
  
  open func keyboardDidShow(_ userInfo: [AnyHashable : Any]) {}
  
  open func keyboardDidHide(_ userInfo: [AnyHashable : Any]) {}
}
