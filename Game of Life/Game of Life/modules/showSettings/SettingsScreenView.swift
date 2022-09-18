import Foundation
import SwiftUI

struct SettingsScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: SettingsInteractor
  
  // MARK: - Body
  
  var body: some View {
    VStack {
      ZStack(alignment: .leading) {
        Button(action: onBackButtonTapped)  {
          Image("back-arrow")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .tint(AppAppearance.Colors.color_313031)
            .frame(width: 22.5, height: 22.5)
        }
        Text("Settings")
          .font(AppAppearance.Fonts.medium_18)
          .frame(maxWidth: .infinity)
      }
      .padding(.horizontal, AppAppearance.Spacing.large)
      .padding(.top, AppAppearance.Spacing.small)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Slider(
        value: $interactor.viewModel.grid.size,
        min: interactor.viewModel.grid.minSize,
        max: interactor.viewModel.grid.maxSize
      )
      .frame(width: 250)
      
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(AppAppearance.Colors.color_ffffff)
  }
  
  // MARK: - Private methods
  
  private func onBackButtonTapped() {
    interactor.closeSettings()
  }
}

// MARK: - SettingsScreenView+Slider

private extension SettingsScreenView {
  struct Slider: View {
    // MARK: - Datasource properties
    
    @Binding
    var value: Int
    @State
    private var initialDragValue: Int?
    let min: Int
    let max: Int
    var thumbSize: CGFloat = 30
    
    // MARK: - Body
    
    var body: some View {
      GeometryReader { proxy in
        ZStack(alignment: .top) {
          AppAppearance.Colors.color_313031
            .frame(height: 3)
            .offset(y: thumbSize / 2)
          
          VStack(spacing: AppAppearance.Spacing.extraSmall) {
            AppAppearance.Colors.color_313031
              .frame(width: 12.5, height: thumbSize)
            Text("\(value)")
              .font(AppAppearance.Fonts.light_13)
          }
          .offset(x: -proxy.size.width/2)
          .offset(x: getDragProgress(with: value)*proxy.size.width)
        }
        .gesture(
          DragGesture()
            .onChanged({
              onThumbDrag(
                offset: $0.translation.width,
                viewWidth: proxy.size.width
              )
            })
            .onEnded({ _ in
              initialDragValue = nil
            })
        )
      }
    }
    
    // MARK: - Private methods
    
    private func onThumbDrag(offset: Double, viewWidth: Double) {
      if initialDragValue == nil {
        initialDragValue = value
      }
      
      let dragProgress = abs(offset) / viewWidth
      let dragMultiplier = offset < 0 ? -1 : 1
      let dragDelta = dragProgress * Double(max - min)
      let newValue = (initialDragValue ?? 0) + dragMultiplier*Int(dragDelta)
      
      value = Swift.min(max, Swift.max(min, newValue))
    }
    
    private func getDragProgress(with value: Int) -> Double {
      return Double(value - min) / Double(max-min)
    }
  }
}

// MARK: - Preview

struct SettingsScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsScreenView(
      interactor: .init(
        appState: .init(initialRoute: .settings)
      )
    )
  }
}
