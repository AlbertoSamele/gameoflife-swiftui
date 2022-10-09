import Foundation
import SwiftUI
import UIKit
import Lottie

struct LottieAnimationView: UIViewRepresentable {
  @Binding
  var isLoading: Bool
  let size: CGSize
  
  func updateUIView(_ uiView: UIView, context: Context) {}
  
  func makeUIView(context: Context) -> UIView {
    let animationView = AnimationView(name: "loader")
    animationView.frame = CGRect(origin: .zero, size: size)
    animationView.loopMode = .loop
    if isLoading {
      animationView.play()
    }
    return animationView
  }
}
