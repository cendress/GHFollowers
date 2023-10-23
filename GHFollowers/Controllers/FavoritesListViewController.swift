//
//  FavoriteLIstViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/5/23.
//

import UIKit

class FavoritesListViewController: UIViewController {
  
  let tableView = UITableView()
  var favorites: [Follower] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func getFavorites() {
    PersistenceManager.retrieveFavorites { result in
      switch result {
      case .success(let favorites):
        print(favorites)
      case .failure(let error):
        break
      }
    }
  }
}
