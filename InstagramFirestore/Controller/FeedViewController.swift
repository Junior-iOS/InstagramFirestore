//
//  FeedViewController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import UIKit
import Firebase

class FeedViewController: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private var posts: [Post] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPosts()
    }
    
    // MARK: - Methods
    private func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Feed"
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
            print("❌ Failed to sign out")
        }
    }
    
    
    // MARK: - API
    private func fetchPosts() {
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
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
