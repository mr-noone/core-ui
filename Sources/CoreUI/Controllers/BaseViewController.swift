import UIKit

open class BaseViewController: UIViewController {
  // MARK: - Properties
  
  open var navigation: Navigation? { return nil }
  
  // MARK: - View lifecycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    setNeedsUpdateNavigationItem()
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    needsUpdateNavigationBar()
    DispatchQueue.main.async {
      self.navigationController?.navigationBar.sizeToFit()
    }
  }
  
  open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    needsUpdateNavigationBar()
  }
}

// MARK: - Public

public extension BaseViewController {
  func setNeedsUpdateNavigationItem() {
    if let navigation = navigation {
      navigationItem.title = navigation.title
      navigationItem.titleView = navigation.titleView
      navigationItem.largeTitleDisplayMode = navigation.largeTitleMode
      navigationItem.rightBarButtonItems = navigation.rightActions?.compactMap { $0.barButtonItem }
      navigationItem.leftBarButtonItems = navigation.leftActions?.compactMap { $0.barButtonItem }
      
      if let backItem = navigation.customBackItem, shouldShowBackButtonItem() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backItem.barButtonItem
        navigationItem.leftBarButtonItem?.action = #selector(didTouchBackButton)
        navigationItem.leftBarButtonItem?.target = self
      }
    }
  }
}

// MARK: - Internal

internal extension BaseViewController {
  @objc func didTouchBackButton() {
    navigationController?.popViewController(animated: true)
  }
  
  func shouldShowBackButtonItem() -> Bool {
    return (navigationController?.viewControllers ?? []).count > 1
      && (navigationItem.leftBarButtonItems ?? []).isEmpty
  }
  
  func needsUpdateNavigationBar() {
    if let navigation = navigation, let navigationBar = navigationController?.navigationBar {
      navigationBar.backIndicatorImage = navigation.backIndicatorImage
      navigationBar.backIndicatorTransitionMaskImage = navigation.backIndicatorTransitionMaskImage
      navigationBar.prefersLargeTitles = navigation.prefersLargeTitles
      navigationBar.isTranslucent = navigation.isTranslucent
      navigationBar.tintColor = navigation.barTintColor
      navigationBar.barTintColor = navigation.barBackgroundColor
      navigationBar.barStyle = navigation.barStyle
      navigationBar.titleTextAttributes = navigation.titleTextAttributes
      navigationBar.largeTitleTextAttributes = navigation.largeTitleTextAttributes
      navigationBar.shadowImage = navigation.shadowImage
      
      UIBarMetrics.allCases.forEach {
        navigationBar.setBackgroundImage(navigation.backgroundImage(for: $0), for: $0)
      }
      
      setNeedsStatusBarAppearanceUpdate()
    }
  }
}
