//
//  ProfileCell.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 08/10/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom-7")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var viewModel: PostViewModel? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        DispatchQueue.main.async {
            self.imageView.sd_setImage(with: viewModel.imageUrl)
        }
    }
    
}
