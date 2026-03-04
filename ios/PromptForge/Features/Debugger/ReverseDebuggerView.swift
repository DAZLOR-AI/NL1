import SwiftUI

struct ReverseDebuggerView: View {
    @State private var output = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reverse Prompt Debugger")
            TextEditor(text: $output)
                .frame(height: 120)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Button("Diagnose") {}
                .buttonStyle(.bordered)
        }
    }
}
