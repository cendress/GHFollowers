//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/20/23.
//

import Foundation

extension Date {
  
//  func convertToMonthYearFormat() -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MMM yyyy"
//    
//    return dateFormatter.string(from: self)
//  }
  
  func convertToMonthYearFormat() -> String {
    return formatted(.dateTime.month().year())
  }
}
