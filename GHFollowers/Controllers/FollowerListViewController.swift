//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/7/23.
//

import UIKit

class FollowerListViewController: UIViewController {
  
  enum Section {
    case main
  }
  
  var username: String!
  var followers: [Follower] = []
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollower()
    configureDataSource()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resuseID)
  }
  
  func getFollower() {
    NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let followers):
        self.followers = followers
        self.updateData()
        
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad Stuff happened", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resuseID, for: indexPath) as! FollowerCell
      cell.set(follower: follower)
      return cell
    })
  }
  
  func updateData() {
    var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapShot.appendSections([.main])
    snapShot.appendItems(followers)
    DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true) }
  }
}
