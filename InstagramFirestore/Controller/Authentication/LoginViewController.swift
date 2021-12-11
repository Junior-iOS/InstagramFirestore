//
//  LoginViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "instagram_logo_white"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let emailTextField: UITextField = {
        let textField = CustomTextField(placeholder: "E-mail")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = AuthenticationButton(title: "Log in")
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNotificationObservers()
    }
    
    private func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // MARK: - Actions
    
    @objc func didTapLoginButton() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        showLoader(true)
        
        AuthService.logUserIn(with: email, password: password) { result, error in
            self.showLoader(false)
            
            if let error = error {
                AlertController.showAlert(title: "❌ Failed to log user in", message: "\(error.localizedDescription)", viewController: self)
                return
            }
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationViewController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc func handleResetPassword() {
        let controller = ResetPasswordViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - FormViewModel
extension LoginViewController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}

// MARK: - ResetPasswordDelegate
extension LoginViewController: ResetPasswordDelegate {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordViewController) {
        navigationController?.popViewController(animated: true)
        AlertController.showAlert(title: "Success", message: "We`ve sent a link to your email to reset your password.", viewController: self)
    }
}
