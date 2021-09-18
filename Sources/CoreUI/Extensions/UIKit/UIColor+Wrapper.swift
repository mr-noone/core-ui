import UIKit.UIColor

public extension UIColor {
  @propertyWrapper
  struct Color {
    public let wrappedValue: UIColor
    
    public init(any: UInt32, light: UInt32? = nil, dark: UInt32? = nil) {
      wrappedValue = .init(any: any, light: light, dark: dark)
    }
    
    public init(any: UIColor, light: UIColor? = nil, dark: UIColor? = nil) {
      wrappedValue = .init(any: any, light: light, dark: dark)
    }
  }
  
  convenience init(any: UInt32, light: UInt32? = nil, dark: UInt32? = nil) {
    self.init(
      any: .init(hex6: any),
      light: light != nil ? .init(hex6: light!) : nil,
      dark: dark != nil ? .init(hex6: dark!) : nil
    )
  }
  
  convenience init(any: UIColor, light: UIColor? = nil, dark: UIColor? = nil) {
    self.init {
      switch $0.userInterfaceStyle {
      case .unspecified: return any
      case .light: return light ?? any
      case .dark: return dark ?? any
      @unknown default: fatalError()
      }
    }
  }
}
