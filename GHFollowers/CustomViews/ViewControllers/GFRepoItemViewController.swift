//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/19/23.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
  func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
  
  weak var delegate: GFRepoItemVCDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "perso")
  }
  
  override func actionButtonTapped() {
    delegate.didTapGitHubProfile(for: user)
  }
}
