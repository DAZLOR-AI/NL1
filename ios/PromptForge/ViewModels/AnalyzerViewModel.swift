import Foundation
import Combine

final class AnalyzerViewModel: ObservableObject {
    @Published var promptText: String = ""
    @Published var analysis: PromptAnalysis?
    @Published var isRunning = false

    private let llm: LLMServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(llm: LLMServiceProtocol) { self.llm = llm }

    func analyze() {
        isRunning = true
        llm.analyzePrompt(promptText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isRunning = false
                if case .failure = completion { self?.analysis = nil }
            } receiveValue: { [weak self] in self?.analysis = $0 }
            .store(in: &cancellables)
    }
}
