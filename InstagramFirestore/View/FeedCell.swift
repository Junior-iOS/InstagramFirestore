//
//  FeedCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
}

class FeedCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let kProfileImageSize: CGFloat = 40.0
    private var stackView = UIStackView()
    weak var delegate: FeedCellDelegate?
    
    var viewModel: PostViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.backgroundColor = .systemGray
        return image
    }()
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: kProfileImageSize, width: kProfileImageSize)
        profileImageView.layer.cornerRadius = kProfileImageSize / 2
        
        addSubview(userNameButton)
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionbuttons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: stackView.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionsLabel)
        captionsLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionsLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureActionbuttons() {
        stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
    
    @objc func didTapUsername() {
        print("didTapUsername")
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        captionsLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        userNameButton.setTitle(viewModel.userName, for: .normal)
        
        likesLabel.text = viewModel.likesLabelText
    }
    
    // MARK: - Actions
    @objc private func didTapComments() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowCommentsFor: viewModel.post)
    }
    
    @objc private func didTapLike() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }
}
