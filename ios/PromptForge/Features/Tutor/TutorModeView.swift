import SwiftUI

struct TutorModeView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("AI Tutor Mode").font(.title2.bold())
            Text("Adaptive coaching, guided exercises, and live rewrites.")
                .foregroundStyle(.secondary)
            ReverseDebuggerView()
        }
        .padding()
    }
}
