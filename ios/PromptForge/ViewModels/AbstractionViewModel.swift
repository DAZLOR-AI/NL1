import Foundation
import Combine

final class AbstractionViewModel: ObservableObject {
    @Published var goal: String = ""
    @Published var result: AbstractionResult?
    @Published var isProcessing = false

    private let llm: LLMServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(llm: LLMServiceProtocol) { self.llm = llm }

    func transform() {
        isProcessing = true
        llm.runAbstraction(goal: goal)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isProcessing = false
                if case .failure = completion { self?.result = nil }
            } receiveValue: { [weak self] in self?.result = $0 }
            .store(in: &cancellables)
    }
}
