import Foundation
import SwiftUI

struct NativeNavigation: Navigator {
  var navigatable: Navigatable
  var animationDuration: Double = 0.2
  
  func push(from fromRoot: RouteType, to toRoot: RouteType) {
    let size = navigatable.size
    
    navigatable.willBeRootOffsetState.wrappedValue.setOffset(x: size.width)
    navigatable.willBeRootState.wrappedValue = toRoot
    
    withAnimation(.easeOut(duration: animationDuration)) {
      navigatable.willBeRootOffsetState.wrappedValue.setOffset(x: .zero)
    }
    withAnimation(.easeIn(duration: 2*animationDuration)) {
      navigatable.rootOffsetState.wrappedValue.translate(x: -size.width)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      navigatable.rootOffsetState.wrappedValue.setOffset(x: .zero)
      navigatable.rootState.wrappedValue = toRoot
      navigatable.willBeRootState.wrappedValue = nil
      navigatable.willBeRootOffsetState.wrappedValue.setOffset(x: .zero)
    }
  }
  
  func pop(from fromRoot: RouteType, to toRoot: RouteType) {
    
  }
}
