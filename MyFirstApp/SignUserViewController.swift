import UIKit
import SnapKit

class SignUserViewController: UIViewController{
    
    // MARK: - Dictionary
    private var dickionaryUsers: [String: String] = ["Tyoma" : "12345678a", "User" : "123456789a"]
    // MARK: - UI
    private let createLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let passwordVerificationTextField = UITextField()
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

private extension SignUserViewController {
    
    func embedViews() {
        [createLabel, loginTextField, passwordTextField, passwordVerificationTextField, signUpButton].forEach { views in
            view.addSubview(views)
        }
    }
}

// MARK: - Setup layout

private extension SignUserViewController {
    
    func setupLayout() {
        createLabel.snp.makeConstraints { make in
            make.bottom.equalTo(loginTextField.snp.top).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp.top).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(44)
        }
        
        passwordVerificationTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.height.equalTo(44)

        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordVerificationTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
        }

    }
}

//MARK: - Setup appearance

private extension SignUserViewController {
    
    func setupAppearance() {
        view.backgroundColor = UIColor.systemBackground
        
        createLabel.font = .systemFont(ofSize: 30, weight: .medium)
        createLabel.text = "Make up a login and password\nLogin must be at least 1 character long\nThe password must be at least 8 characters long and have letters and numbers"
        let attridutedString = NSMutableAttributedString("Make up a login and password\nLogin must be at least 1 character long\nThe password must be at least 8 characters long and have letters and numbers")
        attridutedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 29, length: createLabel.text!.count - 29))
        attridutedString.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: NSRange(location: 29, length: createLabel.text!.count - 29))
        createLabel.attributedText = attridutedString
        createLabel.textAlignment = .center
        createLabel.textColor = .label
        createLabel.numberOfLines = 0
        
        
        
        
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
        
        
        passwordVerificationTextField.placeholder = "Enter the password again"
        passwordVerificationTextField.textColor = .label
        let passwordVerificationPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordVerificationTextField.leftView = passwordVerificationPaddingView
        passwordVerificationTextField.leftViewMode = .always
        passwordVerificationTextField.isSecureTextEntry = true
        passwordVerificationTextField.clearButtonMode = .whileEditing
        
        [loginTextField, passwordTextField, passwordVerificationTextField].forEach { textField in
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
        
        signUpButton.setTitle("Login", for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.setTitle(nil, for: .highlighted)
        signUpButton.setTitleColor(.black, for: .highlighted)
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.systemRed.cgColor
        signUpButton.layer.cornerRadius = 8
        signUpButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    }
}

// MARK: - validate login and password

private extension SignUserViewController {
    
    func validatePassword(_ password: String?) -> Bool {
            guard let password = password else { return false}
            
            let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            
            return passwordPred.evaluate(with: password)
//             showAlert(title: "", message: "")
    }
    
    func verifyPassword(verificationPassword: String?, password: String?) -> Bool {
        guard verificationPassword == password else { return false }
        return true
    }
    
    func validateLogin(_ login: String?) -> Bool {
        if login != nil && login!.count > 0 {
            return true
        } else {
            return false
        }
    }}

//MARK: - Buttons Action

private extension SignUserViewController {
    
    func buttonAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped(sender: UIButton) -> Bool {
        guard dickionaryUsers.keys.contains(loginTextField.text!) == false else {
            showAlert(title: "Such a login already exists", message: "Enter a new login")
            return false}
        guard validateLogin(loginTextField.text) && validatePassword(passwordTextField.text) else {
            showAlert(title: "Login or password are incorrect\nLogin must be at least 1 character long\nThe password must be at least 8 characters long and have letters and numbers", message: "Please enter again")
            return false
        }
//        showAlert(title: "Ok", message: "gg")
        let locationVC = RootViewController()
        SwitchUIViewController.presentViewController(locationVC)
        return true
    }
}

// MARK: - Show alert

private extension SignUserViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension SignUserViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            showConfirmationDialog(loginTextField)
            return false
        case passwordTextField:
            showConfirmationDialog(passwordTextField)
            return false
        case passwordVerificationTextField:
            showConfirmationDialog(passwordVerificationTextField)
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count >= 0 && textField == loginTextField || textField.text!.count >= 0 && textField == passwordTextField || textField.text!.count >= 0 && textField == passwordVerificationTextField {
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
        case passwordVerificationTextField:
            alert.addAction(UIAlertAction(title: "Yes, clear", style: .destructive, handler: { _ in
                self.passwordVerificationTextField.text = ""
            }))
        default:
            break
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

#Preview {
    SignUserViewController()
}

