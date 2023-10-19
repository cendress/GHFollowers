//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/19/23.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoView2.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
}
