//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/19/23.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
  func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
  
  weak var delegate: GFFollowerItemVCDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoView2.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(color: .systemGreen, title: "Get Followers")
  }
  
  override func actionButtonTapped() {
    delegate.didTapGetFollowers(for: user)
  }
}
