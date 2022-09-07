import Foundation
import SwiftUI

struct NativeNavigation: Navigator {
  var navigatable: Navigatable
  var animationDuration: Double = 0.2
  
  func push(from fromRoot: RouteType, to toRoot: RouteType) {
    let size = navigatable.size
    
    navigatable.overimposedTransformsState.wrappedValue.setOffset(x: size.width)
    navigatable.overimposedRootState.wrappedValue = toRoot
    
    withAnimation(.easeOut(duration: animationDuration)) {
      navigatable.overimposedTransformsState.wrappedValue.setOffset(x: .zero)
    }
    withAnimation(.easeIn(duration: 2*animationDuration)) {
      navigatable.rootTransformsState.wrappedValue.translate(x: -size.width)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      navigatable.rootTransformsState.wrappedValue.setOffset(x: .zero)
      navigatable.rootState.wrappedValue = toRoot
      navigatable.overimposedRootState.wrappedValue = nil
      navigatable.overimposedTransformsState.wrappedValue.setOffset(x: .zero)
    }
  }
  
  func pop(from fromRoot: RouteType, to toRoot: RouteType) {
    let size = navigatable.size
    
    navigatable.underimposedTransformsState.wrappedValue.setOffset(x: -size.width*0.5)
    navigatable.underimposedRootState.wrappedValue = toRoot
    
    withAnimation(.easeOut(duration: animationDuration)) {
      navigatable.underimposedTransformsState.wrappedValue.setOffset(x: .zero)
    }
    withAnimation(.easeIn(duration: animationDuration)) {
      navigatable.rootTransformsState.wrappedValue.translate(x: size.width)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
      navigatable.rootTransformsState.wrappedValue.setOffset(x: .zero)
      navigatable.rootState.wrappedValue = toRoot
      navigatable.underimposedRootState.wrappedValue = nil
      navigatable.underimposedTransformsState.wrappedValue.setOffset(x: .zero)
    }
  }
}
