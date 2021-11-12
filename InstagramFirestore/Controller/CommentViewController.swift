//
//  CommentController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 01/11/21.
//

import UIKit

class CommentViewController: UICollectionViewController {
    
    // MARK: - Properties
    private var post: Post
    private var comments = [Comment]()
    
    private lazy var commentInputView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentView = CommentInputAccessoryView(frame: frame)
        commentView.delegate = self
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
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchComments()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    private func setupCollectionView() {
        navigationItem.title = "Comments"
        
        collectionView.register(CommentsCell.self, forCellWithReuseIdentifier: CommentsCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    // MARK: - API
    private func fetchComments() {
        CommentService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource / UICollectionViewDelegate
extension CommentViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsCell.identifier, for: indexPath) as? CommentsCell else { return UICollectionViewCell() }
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
}

// MARK: - CommentInputAccessoryViewDelegate
extension CommentViewController: CommentInputAccessoryViewDelegate {
    func inputView(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String) {
        if comment.isEmpty {
            AlertController.showAlert(message: "You need to comment something before trying to post it.", viewController: self)
        } else {
            guard let tab = self.tabBarController as? MainTabController, let user = tab.user else { return }
            self.showLoader(true)
            
            CommentService.uploadComment(comment: comment, postID: post.postId, user: user) { error in
                self.showLoader(false)
                inputView.clearCommentText()
            }
        }
    }
}
