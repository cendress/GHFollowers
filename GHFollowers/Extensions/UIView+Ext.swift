//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/25/23.
//

import UIKit

extension UIView {
  
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubviews(view)
    }
  }
}
