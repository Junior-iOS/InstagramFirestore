//
//  ProfileViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit
import AudioToolbox

class ProfileViewController: UICollectionViewController {

    // MARK: - Properties\
    private let cellIdentifier = "ProfileCell"
    private let headerIdentifier = "ProfileHeader"
    var user: User? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        configureCollectionView()
        fetchUser()
    }
    
    // MARK: - Helpers
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    // MARK: - API
    private func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = self.user?.userName
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? ProfileHeader else { return UICollectionReusableView() }
        
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        } else {
            print("User not yet set")
        }
        
        return header
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - SPACES BETWEEN CELLS AND BETWEEN ROWS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
