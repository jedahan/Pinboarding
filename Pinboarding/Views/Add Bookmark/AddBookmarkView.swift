import SwiftUI

struct AddBookmarkView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: AddBookmarkViewModel

    // MARK: - Life cycle

    init(
        viewModel: AddBookmarkViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("URL")
            TextField("", text: $viewModel.urlString)

            Text("Title")
            TextField("", text: $viewModel.title)

            Text("Description")
            TextEditor(text: $viewModel.description)

            Text("Tags")
            TextField("", text: $viewModel.tags)

            HStack {
                Button("Cancel") {}
                    .padding()

                Spacer()

                Button("Add") {
                    viewModel.save()
                }
                .disabled(!viewModel.isValid)
                .padding()
            }
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct AddBookmarkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AddBookmarkView(
                viewModel: AddBookmarkViewModel()
            )
            .frame(width: 320)
            .preferredColorScheme(.light)

            AddBookmarkView(
                viewModel: AddBookmarkViewModel()
            )
            .frame(width: 320)
            .preferredColorScheme(.dark)
        }
    }
}
