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
  
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    
  }
  
  func getFavorites() {
    PersistenceManager.retrieveFavorites { result in
      switch result {
      case .success(let favorites):
        self.favorites = favorites
      case .failure(let error):
        break
      }
    }
  }
}

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
    let favorite = favorites[indexPath.row]
    cell.set(favorite: favorite)
    return cell
  }
}
