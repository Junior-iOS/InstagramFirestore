//
//  ResetPasswordViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 09/12/21.
//

import UIKit

protocol ResetPasswordDelegate: AnyObject {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordViewController)
}

class ResetPasswordViewController: UIViewController {

    // MARK: - Properties
    private let emailTextField = CustomTextField(placeholder: "E-mail")
    private var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPasswordDelegate?
    
    private let iconImage: UIImageView = {
        let image = UIImageView(image: .appImage(.instagram_logo_white))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let resetPasswordButton: UIButton = {
        let button = AuthenticationButton(title: "Reset Password")
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(handleDissmissal), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        configureGradientLayer()
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    // MARK: - Action
    @objc private func handleResetPassword() {
        guard let email = emailTextField.text else { return }
        showLoader(true)
        
        AuthService.resetPassword(with: email) { error in
            if let error = error {
                AlertController.showAlert(title: "Failed to reset password", message: "\(error.localizedDescription)", viewController: self)
                self.showLoader(false)
                return
            }
            
            self.delegate?.controllerDidSendResetPasswordLink(self)
        }
    }
    
    @objc private func handleDissmissal() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange(sender: UITextField) {
        viewModel.email = sender.text
        updateForm()
    }
}

// MARK: - FormViewModel
extension ResetPasswordViewController: FormViewModel {
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        resetPasswordButton.isEnabled = viewModel.formIsValid
    }
}
