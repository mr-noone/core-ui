import UIKit.UIColor

public extension UIColor {
  var hexString: String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: nil)
    let rgb = UInt32(r * 0xff) << 0x10 | UInt32(g * 0xff) << 0x08 | UInt32(b * 0xff) << 0x00
    return String(format: "#%06X", rgb)
  }
  
  convenience init(hex string: String, alpha: CGFloat = 1) {
    let string = string
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")
    let scanner = Scanner(string: string)
    var color: UInt64 = 0
    scanner.scanHexInt64(&color)
    self.init(hex6: UInt32(clamping: color), alpha: alpha)
  }
  
  convenience init(hex1 hex: UInt8, alpha: CGFloat = 1) {
    let w = CGFloat(hex) / 0xf
    self.init(white: w, alpha: alpha)
  }
  
  convenience init(hex2 hex: UInt8, alpha: CGFloat = 1) {
    let w = CGFloat(hex) / 0xff
    self.init(white: w, alpha: alpha)
  }
  
  convenience init(hex3 hex: UInt16, alpha: CGFloat = 1) {
    let r = CGFloat((hex & 0xf00) >> 0x8) / 0xf
    let g = CGFloat((hex & 0x0f0) >> 0x4) / 0xf
    let b = CGFloat((hex & 0x00f) >> 0x0) / 0xf
    self.init(red: r, green: g, blue: b, alpha: alpha)
  }
  
  convenience init(hex6 hex: UInt32, alpha: CGFloat = 1) {
    let r = CGFloat((hex & 0xff0000) >> 0x10) / 0xff
    let g = CGFloat((hex & 0x00ff00) >> 0x08) / 0xff
    let b = CGFloat((hex & 0x0000ff) >> 0x00) / 0xff
    self.init(red: r, green: g, blue: b, alpha: alpha)
  }
}
