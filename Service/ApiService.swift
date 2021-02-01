//
//  ApiService.swift
//  AppcentAssignment
//
//  Created by Batuhan Baran on 29.01.2021.
//

import Foundation
import Alamofire


class ApiService {
    
    fileprivate var url = "https://rawg-video-games-database.p.rapidapi.com/games"
    let rapidApiKey = "?rapidapi-key=711db759camshfb81bc981fde4dbp1fcc63jsn6cda90b689b2"
    
    
    func fetchData(completionHandler: @escaping(Game) -> Void){
        
        AF.request(self.url + rapidApiKey).responseData { response in
            
            guard let data = response.data else {return}
            
            do{
                
                let jsonData = try JSONDecoder().decode(Game.self, from: data)
                completionHandler(jsonData)
                
            }catch let error{
                
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchGameDetail(id: Int,completionHandler: @escaping(GameDetail) -> Void) {
        
        AF.request(self.url + "/" + String(id) + rapidApiKey).responseData { response in
            
            guard let data = response.data else {return}
            
            do{
                
                let jsonData = try JSONDecoder().decode(GameDetail.self, from: data)
                completionHandler(jsonData)
                
            }catch let error{
                
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchFavoriteGames(id: Int,completionHandler: @escaping(FavoriteGame) -> Void) {
        
        AF.request(self.url + "/" + String(id) + rapidApiKey).responseData { response in
            
            guard let data = response.data else {return}
            
            do{
                
                let jsonData = try JSONDecoder().decode(FavoriteGame.self, from: data)
                completionHandler(jsonData)
                
            }catch let error{
                
                print(error.localizedDescription)
            }
        }
    }
    
}


