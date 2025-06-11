import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let welcomeLabel = UILabel()
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        labelAppearance()
        
        welcomeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        }
    
    func labelAppearance() {
        welcomeLabel.text = "Hello, welcome!"
        welcomeLabel.textColor = .label
        welcomeLabel.font = .systemFont(ofSize: 30, weight: .bold)
    }
}

#Preview {
    HomeViewController()
}
