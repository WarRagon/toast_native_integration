import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let toastChannel = FlutterMethodChannel(name: "toast_channel",
                                                binaryMessenger: controller.binaryMessenger)
        
        toastChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "showToast":
                if let args = call.arguments as? [String: Any],
                   let message = args["message"] as? String {
                    self?.showToast(message: message)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS",
                                        message: "Invalid arguments",
                                        details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func showToast(message: String) {
        DispatchQueue.main.async {
            if let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                rootVC.present(alert, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.dismiss(animated: true)
                }
            }
        }
    }
}