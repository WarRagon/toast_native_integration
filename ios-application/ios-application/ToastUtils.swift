import SwiftUI
import UIKit

class ToastUtils {
    static func show(_ message: String?) {
        guard let message = message else { return }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert
            )
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let viewController = windowScene.windows.first?.rootViewController {
                viewController.present(alert, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.dismiss(animated: true)
                }
            }
        }
    }
}