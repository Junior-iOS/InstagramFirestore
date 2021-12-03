//
//  UserCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 28/10/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let identifier = "userCell"
    let kImageDimension: Double = 48.0
    var viewModel: UserCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        return image
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Venom"
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Eddie Brock"
        label.textColor = .lightGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(profileImage)
        profileImage.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImage.setDimensions(height: kImageDimension, width: kImageDimension)
        profileImage.layer.cornerRadius = kImageDimension / 2
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: profileImage.rightAnchor, paddingLeft: 8)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        DispatchQueue.main.async {
            self.profileImage.sd_setImage(with: viewModel.profileImage)
            self.userNameLabel.text = viewModel.userName
            self.fullNameLabel.text = viewModel.fullName
        }
    }
}
