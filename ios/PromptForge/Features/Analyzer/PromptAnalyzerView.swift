import SwiftUI

struct PromptAnalyzerView: View {
    @StateObject private var vm: AnalyzerViewModel

    init() {
        let client = APIClient(baseURL: URL(string: "https://api.promptforge.app")!, tokenProvider: { nil })
        _vm = StateObject(wrappedValue: AnalyzerViewModel(llm: LLMService(apiClient: client)))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextEditor(text: $vm.promptText)
                    .frame(height: 140)
                    .padding(8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Button("Analyze Prompt") { vm.analyze() }
                    .buttonStyle(.borderedProminent)
                if let analysis = vm.analysis {
                    PromptStructureCard(title: "Clarity", value: analysis.clarityScore)
                    PromptStructureCard(title: "Specificity", value: analysis.specificityScore)
                    PromptStructureCard(title: "Determinism", value: analysis.determinismScore)
                    PromptStructureCard(title: "Structure", value: analysis.structureScore)
                }
            }
            .padding()
        }
    }
}

struct PromptStructureCard: View {
    let title: String
    let value: Int
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(value)/100").bold()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
