//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/25/23.
//

import UIKit

extension UITableView {
  
  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
  
  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }
}
