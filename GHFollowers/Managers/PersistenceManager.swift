//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Christopher Endress on 10/22/23.
//

import Foundation

enum PersistenceManager {
  static private let defaults = UserDefaults.standard
  
  enum Keys {
    static let favorites = "Favorites"
  }
  
  static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
    guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
      completed(.success([]))
      return
    }
    
    do {
      let decoder = JSONDecoder()
      let favorites = try decoder.decode([Follower].self, from: favoritesData)
      completed(.success(favorites))
    } catch {
      completed(.failure(.unableToFavorite))
    }
  }
  
  static func save(favorites: [Follower]) -> GFError? {
    
    do {
      let encoder = JSONEncoder()
      let encodedFavorites = try encoder.encode(favorites)
      defaults.setValue(encodedFavorites, forKey: Keys.favorites)
      return nil
    } catch {
      return .unableToFavorite
    }
  }
}
