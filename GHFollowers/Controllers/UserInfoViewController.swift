//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/16/23.
//

import UIKit

class UserInfoViewController: UIViewController {
  
  let headerView = UIView()
  
  var username: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
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
  
  func layoutUI() {
    view.addSubview(headerView)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      headerView.heightAnchor.constraint(equalToConstant: 100)
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
