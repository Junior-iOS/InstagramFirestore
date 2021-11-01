//
//  CommentController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 01/11/21.
//

import UIKit

class CommentViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        navigationItem.title = "Comments"
        collectionView.register(CommentsCell.self, forCellWithReuseIdentifier: CommentsCell.identifier)
        collectionView.backgroundColor = .white
    }

}

// MARK: UICollectionViewDataSource / UICollectionViewDelegate
extension CommentViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsCell.identifier, for: indexPath) as? CommentsCell else { return UICollectionViewCell() }
                
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
