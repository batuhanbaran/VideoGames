//
//  FavoriteViewController.swift
//  AppcentAssignment
//
//  Created by Batuhan Baran on 29.01.2021.
//

import UIKit
import SDWebImage

class FavoriteViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var favoriteGames = [FavoriteGame]()

    @IBOutlet var collectionView: UICollectionView!
    
    static var favArray : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.favoriteGames.removeAll(keepingCapacity: false)
        
        for fav in FavoriteViewController.favArray{
            
            ApiService().fetchFavoriteGames(id: fav) { (favorite) in
                
                self.favoriteGames.append(favorite)
                self.collectionView.reloadData()
            }
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favoriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.gameName.text = favoriteGames[indexPath.row].name
        cell.gameRatingReleasing.text = String(favoriteGames[indexPath.row ].rating) + " / " + favoriteGames[indexPath.row].released

        let imageUrl = URL(string: "\(favoriteGames[indexPath.row].background_image)")
        
        if let url = imageUrl{
            
            cell.gameImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        UserDefaults.standard.set(favoriteGames[indexPath.row].id, forKey: "selectedGameId")
        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
    
    }

}
