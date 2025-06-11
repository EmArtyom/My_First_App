import UIKit

open class SwitchUIViewController: UIViewController {
    
    public static func presentViewController(_ view: UIViewController){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: {
            window.rootViewController = view
        })
    }
}

