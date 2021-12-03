//
//  NotificationCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/12/21.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    static let identifier = "notificationCell"
    private let kImageDimension = 48.0
    private let kPadding = 12.0
    private let kPostImageSize = 40.0
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        return image
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Venom"
        return label
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
        
        return image
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        
        addSubview(profileImage)
        profileImage.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImage.setDimensions(height: kImageDimension, width: kImageDimension)
        profileImage.layer.cornerRadius = kImageDimension / 2
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profileImage, leftAnchor: profileImage.rightAnchor, paddingLeft: 8)
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor, paddingRight: kPadding, width: 100, height: 32)
        followButton.isHidden = true
        
        addSubview(postImage)
        postImage.centerY(inView: self)
        postImage.anchor(right: rightAnchor, paddingRight: kPadding, width: kPostImageSize, height: kPostImageSize)
    }
    
    @objc private func handleFollowTapped() {
        print("handleFollowTapped")
    }
    
    @objc private func handlePostTapped() {
        print("handlePostTapped")
    }

}
