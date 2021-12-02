//
//  FeedViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit
import Firebase

class FeedViewController: UICollectionViewController {
    // MARK: - Properties
    
    private let reuseIdentifier = "Cell"
    private var posts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var post: Post?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        fetchPosts()
    }
    
    // MARK: - Methods
    private func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(EmptyStateCell.self, forCellWithReuseIdentifier: EmptyStateCell.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginViewController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            AlertController.showAlert(message: "❌ Failed to sign out", viewController: self)
        }
    }
    
    @objc private func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
    // MARK: - API
    private func fetchPosts() {
        guard post == nil else { return }
        
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPost()
        }
    }
    
    private func checkIfUserLikedPost() {
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                    self.posts[index].didLike = didLike
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if post != nil {
            return 1
        } else {
            return posts.count > 0 ? posts.count : 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if posts.count == 0 && post == nil {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyStateCell.identifier, for: indexPath) as? EmptyStateCell else { return UICollectionViewCell() }
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        cell.delegate = self
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: view.frame.width, height: height)
    }
}

extension FeedViewController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentViewController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            PostService.unlikePosts(post: post) { error in
                if let error = error {
                    AlertController.showAlert(message: error.localizedDescription, viewController: self)
                } else {
                    cell.likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                    cell.likeButton.tintColor = .white
                    cell.viewModel?.post.likes = post.likes - 1
                }
            }
        } else {
            PostService.likePosts(post: post) { error in
                if let error = error {
                    AlertController.showAlert(message: error.localizedDescription, viewController: self)
                } else {
                    cell.likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                    cell.likeButton.tintColor = .red
                    cell.viewModel?.post.likes = post.likes + 1
                }
            }
        }
    }
    
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileViewController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
