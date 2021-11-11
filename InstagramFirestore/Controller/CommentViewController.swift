//
//  CommentController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 01/11/21.
//

import UIKit

class CommentViewController: UICollectionViewController {
    
    private lazy var commentInputView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentView = CommentInputAccessoryView(frame: frame)
        return commentView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return commentInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupCollectionView() {
        navigationItem.title = "Comments"
        
        collectionView.register(CommentsCell.self, forCellWithReuseIdentifier: CommentsCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }

}

// MARK: UICollectionViewDataSource / UICollectionViewDelegate
extension CommentViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
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
