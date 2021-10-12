import UIKit

public final class BarButtonItem: UIBarButtonItem {
  public typealias Action = Navigation.Item.Action
  public typealias Style = UIBarButtonItem.Style
  
  private var actionClosure: Action?
  
  init(style: Style, action: Action?) {
    super.init()
    self.style = style
    self.actionClosure = action
    self.action = #selector(didTap)
    self.target = self
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public convenience init(title: String, style: Style, action: Action?) {
    self.init(style: style, action: action)
    self.title = title
  }
  
  public convenience init(image: UIImage, style: Style, action: Action?) {
    self.init(style: style, action: action)
    self.image = image
  }
  
  @objc private func didTap() {
    actionClosure?()
  }
}
