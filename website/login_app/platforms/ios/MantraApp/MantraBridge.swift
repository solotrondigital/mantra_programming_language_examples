import Foundation

public class MantraBridge: NSObject {
    private let onMessageCallback: (String) -> String

    public init(onMessageCallback: @escaping (String) -> String) {
        self.onMessageCallback = onMessageCallback
        super.init()
    }

    public func dispatchAction(action: String, payload: [String: Any], completion: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let requestJson = "{\"action\":\"\(action)\"}"
            let response = self.onMessageCallback(requestJson)
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }

    public func dispatchLifecycleEvent(eventName: String, state: String) {
        // Native lifecycle notification
    }
}
