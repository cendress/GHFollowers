//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/16/23.
//

import UIKit

class UserInfoViewController: UIViewController {
  
  let headerView = UIView()
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  
  var username: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    layoutUI()
    
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        }
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  func layoutUI() {
    view.addSubview(headerView)
    view.addSubview(itemViewOne)
    view.addSubview(itemViewTwo)
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    itemViewOne.translatesAutoresizingMaskIntoConstraints = false
    itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      headerView.heightAnchor.constraint(equalToConstant: 100),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
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