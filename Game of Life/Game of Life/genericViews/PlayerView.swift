import SwiftUI
import UIKit
import AVKit

struct PlayerView: UIViewRepresentable {
  let url: URL?
  
  func updateUIView(
    _ uiView: UIView,
    context: UIViewRepresentableContext<PlayerView>
  ) {}
  
  func makeUIView(context: Context) -> UIView {
    guard let url = url else {
      return UIView()
    }
    
    return UIKitPlayerView(url: url)
  }
}

fileprivate class UIKitPlayerView: UIView {
  // MARK: - UI properties
  
  private var playerLayer = AVPlayerLayer()
  
  // MARK: - Private properties
  
  private var videoPlayer: AVPlayerLooper?
  
  // MARK: - Inits
  
  init(url: URL) {
    super.init(frame: .zero)
    
    let item = AVPlayerItem(asset: .init(url: url))
    let player = AVQueuePlayer()
    let playerLooper = AVPlayerLooper(player: player, templateItem: item)
    
    videoPlayer = playerLooper
    playerLayer.player = player
    playerLayer.videoGravity = .resizeAspectFill
    layer.addSublayer(playerLayer)
    
    player.play()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Overriden methods
  
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = bounds
  }
}
