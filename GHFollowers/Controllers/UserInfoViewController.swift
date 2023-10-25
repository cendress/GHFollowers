//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/16/23.
//

import UIKit

protocol UserInfoVCDelegate: class {
  func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {
  
  let headerView = UIView()
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  var itemViews: [UIView] = []
  let dateLabel = GFBodyLabel(textAlignment: .center)
  
  var username: String!
  weak var delegate: UserInfoVCDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    layoutUI()
    getUserInfo()
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.configureUIElements(with: user)
        }
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
  
  func configureUIElements(with user: User) {
    let repoItemVC = GFRepoItemViewController(user: user)
    repoItemVC.delegate = self
    
    let followerItemsVC = GFFollowerItemViewController(user: user)
    followerItemsVC.delegate = self
    
    self.add(childVC: repoItemVC, to: self.itemViewOne)
    self.add(childVC: followerItemsVC, to: self.itemViewTwo)
    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
    self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
  }
  
  func layoutUI() {
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ])
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 210),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}

extension UserInfoViewController: GFRepoItemVCDelegate {
  
  func didTapGitHubProfile(for user: User) {
    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "OK")
      return
    }
    
    presentSafariVC(with: url)
  }
}

extension UserInfoViewController: GFFollowerItemVCDelegate {
  
  func didTapGetFollowers(for user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers.", buttonTitle: "So sad")
      return
    }
    delegate.didRequestFollowers(for: user.login)
    dismissVC()
  }
}
