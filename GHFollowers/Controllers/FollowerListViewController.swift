//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/7/23.
//

import UIKit

class FollowerListViewController: UIViewController {
  
  var username: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    
    NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
      guard let followers = followers else {
        self.presentGFAlertOnMainThread(title: "Bad Stuff happened", message: errorMessage!, buttonTitle: "OK")
        return
      }
      
      print("Followers.count = \(followers.count)")
      print(followers)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
}
