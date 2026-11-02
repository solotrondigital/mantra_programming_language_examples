import UIKit
import SwiftUI

class ViewController: UIViewController {
    private var bridge: MantraBridge!

    override func viewDidLoad() {
        super.viewDidLoad()

        bridge = MantraBridge { [weak self] rawRequest in
            self?.handleNativeRequest(rawRequest)
        }

        let hostingController = UIHostingController(rootView: ContentView())
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        bridge.dispatchLifecycleEvent(eventName: "app_ready", state: "active")
    }

    private func handleNativeRequest(_ requestJson: String) -> String {
        return """{"success":true,"data":{"platform":"ios_native","app":"login_app","status":"ready"}}"""
    }
}
