//
//  LoginViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
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
        textField.keyboardType = .emailAddress
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
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
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
    
    // MARK: - Actions
    
    @objc func didTapLoginButton() {
        print("Tapped")
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
