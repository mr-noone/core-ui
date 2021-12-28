import UIKit.UIFont

public extension UIFont {
  @propertyWrapper
  struct Font {
    public let wrappedValue: UIFont
    
    public init(family: String, weight: Weight, size: CGFloat) {
      let descriptor = UIFontDescriptor(fontAttributes: [
        .traits : [UIFontDescriptor.TraitKey.weight : weight],
        .family : family
      ])
      wrappedValue = UIFont(descriptor: descriptor, size: size)
    }
  }
}
