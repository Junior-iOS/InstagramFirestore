//
//  UploadPostController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 29/10/21.
//

import Foundation
import UIKit

protocol UploadPostDelegate: AnyObject {
    func controllerDidFinishUpoadingPost(_ controller: UploadPostViewController)
}

class UploadPostViewController: UIViewController {
    
    // MARK: - Properties
    private let kTextLength = 100
    weak var delegate: UploadPostDelegate?
    var user: User?
    
    var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    private let  photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var captionContextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter caption..."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Helpers
    private func setupView() {
        view.backgroundColor = . white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapDone))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionContextView)
        captionContextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, width: 12, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(top: captionContextView.bottomAnchor, right: view.rightAnchor, paddingBottom: -8, paddingRight: 12)
    }
    
    // MARK: - Actions
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapDone() {
        guard let image = selectedImage else { return }
        guard let caption = captionContextView.text else { return }
        guard let user = user else { return }
        showLoader(true)
        
        PostService.uploadPost(user: user, caption: caption, image: image) { error in
            self.showLoader(false)
            
            if let error = error {
                AlertController.showAlert(message: error.localizedDescription, viewController: self)
            }
            self.delegate?.controllerDidFinishUpoadingPost(self)
        }
    }
    
    private func checkMaxLength(_ textView: UITextView, maxLength: Int) {
        if textView.text.count > kTextLength {
            textView.deleteBackward()
        }
    }
}


// MARK: - UITEXTVIEW DELEGATE
extension UploadPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView, maxLength: kTextLength)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/\(kTextLength)"
        
        captionContextView.placeholderLabel.isHidden = !captionContextView.text.isEmpty
    }
}
