import Foundation
import SwiftUI

struct NavigatableTransforms {
  private(set) var x: CGFloat
  private(set) var y: CGFloat
  private(set) var alpha: CGFloat
  
  static func identity() -> NavigatableTransforms {
    .init(
      x: 0,
      y: 0,
      alpha: 1
    )
  }
  
  mutating func translate(x: CGFloat = .zero, y: CGFloat = .zero) {
    self.x += x
    self.y += y
  }
  
  mutating func setOffset(x: CGFloat? = nil, y: CGFloat? = nil) {
    if let x = x {
      self.x = x
    }
    if let y = y {
      self.y = y
    }
  }
}

protocol RouteType { }

protocol Navigatable {
  var size: CGSize { get }
  
  var rootState: State<RouteType> { get set }
  var rootTransformsState: State<NavigatableTransforms> { get set }
  
  var overimposedRootState: State<RouteType?> { get set }
  var overimposedTransformsState: State<NavigatableTransforms> { get set }
  
  var underimposedRootState: State<RouteType?> { get set }
  var underimposedTransformsState: State<NavigatableTransforms> { get set }
}

protocol Navigator {
  func push(from fromRoot: RouteType, to toRoot: RouteType)
  func pop(from fromRoot: RouteType, to toRoot: RouteType)
}
