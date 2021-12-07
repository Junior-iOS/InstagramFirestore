//
//  NotificationCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/12/21.
//

import UIKit
import SDWebImage

protocol NotificationCellDelegate: AnyObject {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String)
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String)
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String)
}

class NotificationCell: UITableViewCell {
    
    static let identifier = "notificationCell"
    weak var delegate: NotificationCellDelegate?
    
    var viewModel: NotificationViewModel? {
        didSet {
            configure()
        }
    }
    
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
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
        
        return image
    }()
    
    private lazy var followButton: UIButton = {
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
        configure()
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
        
        contentView.addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor, paddingRight: kPadding, width: 100, height: 32)
        followButton.isHidden = true
        
        contentView.addSubview(postImage)
        postImage.centerY(inView: self)
        postImage.anchor(right: rightAnchor, paddingRight: kPadding, width: kPostImageSize, height: kPostImageSize)
        
        contentView.addSubview(infoLabel)
        infoLabel.centerY(inView: profileImage, leftAnchor: profileImage.rightAnchor, paddingLeft: 8)
        infoLabel.anchor(right: followButton.leftAnchor, paddingRight: 4)
    }
    
    @objc private func handleFollowTapped() {
        guard let viewModel = viewModel else { return }
        if viewModel.notification.isUserFollowed {
            delegate?.cell(self, wantsToUnfollow: viewModel.notification.uid)
        } else {
            delegate?.cell(self, wantsToFollow: viewModel.notification.uid)
        }
    }
    
    @objc private func handlePostTapped() {
        guard let postId = viewModel?.notification.postId else { return }
        delegate?.cell(self, wantsToViewPost: postId)
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
            return
        }
        
        profileImage.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.notificationMessage
        postImage.sd_setImage(with: viewModel.postImageUrl)
        
        followButton.setTitle(viewModel.folloButtonText, for: .normal)
        followButton.backgroundColor = viewModel.followButtonBackgroundColor
        followButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        followButton.isHidden = !viewModel.shouldHidePostImage
        
        postImage.isHidden = viewModel.shouldHidePostImage
    }

}
