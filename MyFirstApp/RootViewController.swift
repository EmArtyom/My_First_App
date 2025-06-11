import UIKit
import SnapKit

class RootViewController: UIViewController{
    
    // MARK: - Доделать словать
    private var dickionaryUsers: [String: String] = ["Tyoma" : "12345678a", "Dasha" : "123456789a"]
    // MARK: - UI
    private let enterLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let enterButton = UIButton()
    private let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupLayout()
        setupAppearance()
        buttonAction()
        
    }
}

// MARK: - Embed views

private extension RootViewController {
    
    func embedViews() {
        [enterLabel, loginTextField, passwordTextField, enterButton, signUpButton].forEach { views in
            view.addSubview(views)
        }
    }
}

// MARK: - Setup layout

private extension RootViewController {
    
    func setupLayout() {
        enterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(loginTextField.snp.top).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(44)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp.top).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(44)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.trailing.equalToSuperview().inset(24)
        }

    }
}

//MARK: - Setup appearance

private extension RootViewController {
    
    func setupAppearance() {
        view.backgroundColor = UIColor.systemBackground
        
        enterLabel.text = "Enter your\n login and password"
        enterLabel.textAlignment = .center
        enterLabel.textColor = .label
        enterLabel.numberOfLines = 0
        enterLabel.font = .systemFont(ofSize: 22, weight: .medium)
        
        loginTextField.textColor = .label
        loginTextField.placeholder = "Login"
        loginTextField.leftView = .none
        let loginPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftView = loginPaddingView
        loginTextField.leftViewMode = .always
        loginTextField.clearButtonMode = .whileEditing
        
        passwordTextField.textColor = .label
        passwordTextField.placeholder = "Password"
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = .whileEditing
        
        [loginTextField, passwordTextField].forEach { textField in
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 8
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
            textField.delegate = self
            textField.font = .systemFont(ofSize: 18, weight: .semibold)
            textField.keyboardType = .default
            textField.returnKeyType = .done
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.smartQuotesType = .no
            textField.smartDashesType = .no
            textField.smartInsertDeleteType = .no
            textField.autocapitalizationType = .none
            textField.accessibilityLanguage = "en-US"
        }
        
        enterButton.setTitle("Login", for: .normal)
        enterButton.backgroundColor = .systemBlue
        enterButton.setTitle(nil, for: .highlighted)
        enterButton.setTitleColor(.black, for: .highlighted)
        enterButton.layer.borderWidth = 2
        enterButton.layer.borderColor = UIColor.systemRed.cgColor
        enterButton.layer.cornerRadius = 8
        enterButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        
        signUpButton.setTitle("Sign Up here", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.blue,
            .font: UIFont.systemFont(ofSize: 20, weight: .regular)
        ]

        signUpButton.setAttributedTitle(
            NSAttributedString(string: "Sign Up here", attributes: attributes),
            for: .normal
        )
    }
}

// MARK: - validate login and password

private extension RootViewController {
    
    func validate(_ password: String?) -> Bool {
        let login = loginTextField.text!
        let passwordCor = passwordTextField.text
        guard let correctPassword = dickionaryUsers[login] else {
            showAlert(title: "Incorrect login", message: "Enter an existing login")
            return false }
        if passwordCor == correctPassword {
            guard let password = password else {
                return false}
            
            let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            
            return passwordPred.evaluate(with: password)
//             showAlert(title: "", message: "")
        } else {
            showAlert(title: "Login or password incorrect", message: "Enter correct password or login")
            return false

        }
    }
    }

//MARK: - Buttons Action

private extension RootViewController {
    
    func buttonAction() {
        enterButton.addTarget(self, action: #selector(enterButtonTapped(sender:)), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func enterButtonTapped(sender: UIButton) -> Bool {
        guard dickionaryUsers.keys.contains(loginTextField.text!) == true else {
            showAlert(title: "Login or password incorrect", message: "Enter correct password or login")
            return false
        }
        guard validate(passwordTextField.text) else {
            return false
        }
        //TODO: - Необходимо доделать
//        MARK: - Доделать вход на экран приветствия
        let locationVC = WelcomeViewController()
        SwitchUIViewController.presentViewController(locationVC)
        return true
    }
    
    @objc func signUpButtonTapped(sender: UIButton) {
        print("Sign Up Tapped")
        let locationVC = SignUserViewController()
        SwitchUIViewController.presentViewController(locationVC)
    }
}

// MARK: - Show alert

private extension RootViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension RootViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            showConfirmationDialog(loginTextField)
            return false
        case passwordTextField:
            showConfirmationDialog(passwordTextField)
            return false
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count > 0 && textField == loginTextField || textField.text!.count > 0 && textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 15
    }
    
    func showConfirmationDialog(_ textField: UITextField) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to clear this sensitive data?", preferredStyle: .alert)

        switch textField {
        case loginTextField:
            alert.addAction(UIAlertAction(title: "Yes, clear", style: .destructive, handler: { _ in
                self.loginTextField.text = ""
            }))
        case passwordTextField:
            alert.addAction(UIAlertAction(title: "Yes, clear", style: .destructive, handler: { _ in
                self.passwordTextField.text = ""
            }))
        default:
            break
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}


#Preview {
    RootViewController()
}
