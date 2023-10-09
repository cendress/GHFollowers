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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
}
