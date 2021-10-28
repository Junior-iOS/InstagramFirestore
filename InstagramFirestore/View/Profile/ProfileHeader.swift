//
//  ProfileHeader.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 08/10/21.
//

import Foundation
import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet {
            configure()
        }
    }
    
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .lightGray
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom-7")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatusText(value: 10, label: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatusText(value: 137, label: "followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = attributedStatusText(value: 124, label: "following")
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        addSubview(labelStackView)
        labelStackView.centerY(inView: profileImageView)
        labelStackView.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        addSubview(buttonsStackView)
        buttonsStackView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        addSubview(topDivider)
        topDivider.anchor(top: buttonsStackView.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        addSubview(bottomDivider)
        bottomDivider.anchor(top: buttonsStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.fullName
            self.profileImageView.sd_setImage(with: viewModel.profileImage)
        }
    }
        
    // MARK: - Actions
    @objc func handleEditProfileButtonTapped() {
        print("handleEditProfileButtonTapped")
    }
    
    // MARK: - Helpers
    private func attributedStatusText(value: Int, label: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: label, attributes: [.font : UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedString
    }
    
}
