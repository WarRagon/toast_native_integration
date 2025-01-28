import SwiftRs
import Tauri
import UIKit
import WebKit

class PingArgs: Decodable {
  let value: String?
}

class ToastArgs: Decodable {
    let value: String?
}

class ExamplePlugin: Plugin {
  @objc public func ping(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(PingArgs.self)
    invoke.resolve(["value": args.value ?? ""])
  }

  @objc public func toast(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(ToastArgs.self)
    let message = args.value ?? "Default message"
    
    DispatchQueue.main.async {
      let alert = UIAlertController(
        title: nil, 
        message: message, 
        preferredStyle: .alert
      )
      
      if let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
        rootVC.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          alert.dismiss(animated: true)
        }
      }
      
      invoke.resolve()
    }
  }
}

@_cdecl("init_plugin_example")
func initPlugin() -> Plugin {
  return ExamplePlugin()
}
