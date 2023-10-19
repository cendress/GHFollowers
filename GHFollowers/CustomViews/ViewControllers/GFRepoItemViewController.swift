//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/19/23.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }
}
