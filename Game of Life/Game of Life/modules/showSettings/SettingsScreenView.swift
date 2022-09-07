import Foundation
import SwiftUI

struct SettingsScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: SettingsInteractor
  
  // MARK: - Body
  
  var body: some View {
    Button("Push") {
      interactor.push()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.red)
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
