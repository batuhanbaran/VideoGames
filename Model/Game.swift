//
//  Game.swift
//  AppcentAssignment
//
//  Created by Batuhan Baran on 29.01.2021.
//

import Foundation

struct Game: Decodable{
    
    var results: [GameResults]
    
}

struct GameResults: Decodable{
    
    var id: Int
    var name: String
    var background_image: String
    var released: String
    var rating: Double
    
}

struct GameDetail: Decodable {
    
    var background_image: String
    var name: String
    var released: String
    var metacritic: Int
    var description: String
}

struct FavoriteGame: Decodable {
    
    var id: Int
    var name: String
    var background_image: String
    var released: String
    var rating: Double
}
