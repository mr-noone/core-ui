import UIKit.UIImage

public extension UIImage {
  convenience init?(color: UIColor, size: CGSize = .init(width: 1, height: 1), scale: CGFloat = UIScreen.main.scale) {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    defer { UIGraphicsEndImageContext() }
    
    color.setFill()
    UIRectFill(.init(origin: .zero, size: size))
    guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
    self.init(cgImage: image)
  }
}
