//
//  CommentsCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 01/11/21.
//

import UIKit

class CommentsCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CommentsCell"
    private let kProfileImageSize: CGFloat = 40.0
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .systemGray
        return image
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "joker ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "Some comment here", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedString
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        profileImageView.setDimensions(height: kProfileImageSize, width: kProfileImageSize)
        profileImageView.layer.cornerRadius = kProfileImageSize / 2
        
        addSubview(commentLabel)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
