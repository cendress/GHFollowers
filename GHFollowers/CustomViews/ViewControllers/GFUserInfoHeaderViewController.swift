//
//  GFUserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/18/23.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {
  
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
  let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
  let locationImageView = UIImageView()
  let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
  let bioLabel = GFBodyLabel(textAlignment: .left)
  
  var user: User!
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
  }
  
  func addSubviews() {
    view.addSubview(avatarImageView)
    view.addSubview(usernameLabel)
    view.addSubview(nameLabel)
    view.addSubview(locationImageView)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
  }
  
  func layoutUI() {
    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12
    
    NSLayoutConstraint.activate([
    
    ])
  }
  
}
