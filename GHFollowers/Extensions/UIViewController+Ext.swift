//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/8/23.
//

import UIKit
import SafariServices

extension UIViewController {
  
  func presentGFAlert(title: String, message: String, buttonTitle: String) {
    let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
    alertViewController.modalPresentationStyle = .overFullScreen
    alertViewController.modalTransitionStyle = .crossDissolve
    present(alertViewController, animated: true)
  }
  
  func presentDefaultError() {
    let alertViewController = GFAlertViewController(
      title: "Something Went Wrong",
      message: "We were unable to complete your task at this time. Please try again.",
      buttonTitle: "OK"
    )
    alertViewController.modalPresentationStyle = .overFullScreen
    alertViewController.modalTransitionStyle = .crossDissolve
    present(alertViewController, animated: true)
  }
  
  func presentSafariVC(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = .systemGreen
    present(safariVC, animated: true)
  }
}
