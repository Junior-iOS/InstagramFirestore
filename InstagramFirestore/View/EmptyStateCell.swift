//
//  EmptyStateCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 31/10/21.
//

import UIKit

class EmptyStateCell: UICollectionViewCell {
    
    static let identifier = "EmptyStateCell"
    let kImageSize: CGFloat = UIScreen.main.bounds.width - 16.0
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your first Post."
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let emptyStateImageView: UIImageView = {
        let image = UIImageView()
        image.image = .appImage(.emptyState)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyStateImageView)
        emptyStateImageView.anchor(top: safeAreaLayoutGuide.bottomAnchor, paddingTop: 20)
        emptyStateImageView.setDimensions(height: kImageSize, width: kImageSize)
        emptyStateImageView.center(inView: self)
        emptyStateImageView.layer.cornerRadius = kImageSize / 2
        
        addSubview(emptyStateLabel)
        emptyStateLabel.anchor(top: emptyStateImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
