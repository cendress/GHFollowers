//
//  User.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/8/23.
//

import Foundation

struct User: Codable {
  let login: String
  let avatarUrl: String
  var name: String?
  var location: String?
  var bio: String?
  let publicRepos: Int
  let publicGists: Int
  let htmlUrl: String
  let following: Int
  let followers: Int
  let createdAt: Date
}
