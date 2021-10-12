import UIKit

open class Navigation {
  public typealias LargeTitleMode = UINavigationItem.LargeTitleDisplayMode
  
  open class Item {
    public typealias Style = UIBarButtonItem.Style
    public typealias Action = () -> ()
    
    // MARK: - Properties
    
    public let title: String?
    public let image: UIImage?
    public let isEnabled: Bool
    public let style: Style
    public let action: Action?
    
    open var barButtonItem: UIBarButtonItem? {
      var item: BarButtonItem
      
      switch (title, image) {
      case let (title?, _): item = BarButtonItem(title: title, style: style, action: action)
      case let (_, image?): item = BarButtonItem(image: image, style: style, action: action)
      default: return nil
      }
      
      item.isEnabled = isEnabled
      return item
    }
    
    // MARK: - Inits
    
    fileprivate init(title: String?, image: UIImage?, isEnabled: Bool, style: Style, action: Action?) {
      self.title = title
      self.image = image
      self.isEnabled = isEnabled
      self.style = style
      self.action = action
    }
    
    public convenience init(title: String, isEnabled: Bool = true, style: Style = .plain, action: Action?) {
      self.init(title: title, image: nil, isEnabled: isEnabled, style: style, action: action)
    }
    
    public convenience init(image: UIImage, isEnabled: Bool = true, style: Style = .plain, action: Action?) {
      self.init(title: nil, image: image, isEnabled: isEnabled, style: style, action: action)
    }
    
    public convenience init(system imageName: String, isEnabled: Bool = true, style: Style = .plain, action: Action?) {
      self.init(title: nil, image: UIImage(systemName: imageName), isEnabled: isEnabled, style: style, action: action)
    }
  }
  
  final public class BackItem: Item {
    // MARK: - Inits
    
    public init(title: String) {
      super.init(title: title, image: nil, isEnabled: true, style: .plain, action: nil)
    }
    
    public init(image: UIImage) {
      super.init(title: nil, image: image, isEnabled: true, style: .plain, action: nil)
    }
    
    public init(system imageName: String) {
      let image = UIImage(systemName: imageName)
      super.init(title: nil, image: image, isEnabled: true, style: .plain, action: nil)
    }
  }
  
  // MARK: - Properties
  
  public let title: String?
  public let titleView: UIView?
  public let largeTitleMode: LargeTitleMode
  public let leftActions: [Item]?
  public let rightActions: [Item]?
  
  open var backIndicatorImage: UIImage? {
    return nil
  }
  
  open var backIndicatorTransitionMaskImage: UIImage? {
    return backIndicatorImage
  }
  
  open var customBackItem: BackItem? {
    return nil
  }
  
  open var prefersLargeTitles: Bool {
    return true
  }
  
  open var isTranslucent: Bool {
    return true
  }
  
  open var barTintColor: UIColor? {
    return nil
  }
  
  open var barBackgroundColor: UIColor? {
    return nil
  }
  
  open var barStyle: UIBarStyle {
    return .default
  }
  
  open var titleTextAttributes: [NSAttributedString.Key : Any]? {
    return nil
  }
  
  open var largeTitleTextAttributes: [NSAttributedString.Key : Any]? {
    return titleTextAttributes
  }
  
  open var shadowImage: UIImage? {
    return nil
  }
  
  // MARK: - Methods
  
  open func backgroundImage(for barMetrics: UIBarMetrics) -> UIImage? {
    return nil
  }
  
  // MARK: - Inits
  
  public init(title: String?, largeTitleMode: LargeTitleMode = .automatic, leftActions: [Item]? = nil, rightActions: [Item]? = nil) {
    self.title = title
    self.titleView = nil
    self.largeTitleMode = largeTitleMode
    self.leftActions = leftActions
    self.rightActions = rightActions
  }
  
  public init(titleView: UIView?, largeTitleMode: LargeTitleMode = .automatic, leftActions: [Item]? = nil, rightActions: [Item]? = nil) {
    self.title = nil
    self.titleView = titleView
    self.largeTitleMode = largeTitleMode
    self.leftActions = leftActions
    self.rightActions = rightActions
  }
}
