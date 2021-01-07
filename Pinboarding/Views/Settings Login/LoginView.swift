import SwiftUI

struct LoginView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: LoginViewModel

    // MARK: - Life cycle

    init(
        viewModel: LoginViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pinboard Auth Token")

            Text("Pinboarding uses auth token to access Pinboard.")
                .font(.footnote)

            SecureField(
                "Auth Token",
                text: $viewModel.authToken
            )

            HStack {
                if !viewModel.isValid {
                    Text(viewModel.authTokenMessage)
                        .foregroundColor(.red)
                }

                Spacer()

                Button("Save") {
                    viewModel.save()
                }
                .disabled(!viewModel.isValid)
            }
        }
    }
}

// MARK: - PreviewProvider

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        let settingsStore = Preview.makeSettingsStore()

        Group {
            LoginView(
                viewModel: LoginViewModel(
                    settingsStore: settingsStore
                )
            )
            .frame(width: 320)
            .padding()
            .preferredColorScheme(.light)

            LoginView(
                viewModel: LoginViewModel(
                    settingsStore: settingsStore
                )
            )
            .frame(width: 320)
            .padding()
            .preferredColorScheme(.dark)
        }
    }
}
