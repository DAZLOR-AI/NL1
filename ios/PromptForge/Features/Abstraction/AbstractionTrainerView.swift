import SwiftUI

struct AbstractionTrainerView: View {
    @StateObject private var vm: AbstractionViewModel

    init() {
        let client = APIClient(baseURL: URL(string: "https://api.promptforge.app")!, tokenProvider: { nil })
        _vm = StateObject(wrappedValue: AbstractionViewModel(llm: LLMService(apiClient: client)))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Intent → Structure")
                    .font(.title2.bold())
                TextField("Describe your goal", text: $vm.goal, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                Button("Transform") { vm.transform() }
                    .buttonStyle(.borderedProminent)
                if let result = vm.result {
                    Text("Intent: \(result.intent)")
                    Text("Output Spec: \(result.outputSpecification)")
                    Text(result.structuredPromptTemplate)
                        .font(.system(.footnote, design: .monospaced))
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
    }
}
