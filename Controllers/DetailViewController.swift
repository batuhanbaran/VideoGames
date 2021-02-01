//
//  DetailViewController.swift
//  AppcentAssignment
//
//  Created by Batuhan Baran on 31.01.2021.
//

import UIKit
import Alamofire
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet var releasedDate: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet weak var metacriticRate: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var likeButtonClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let selectedGameId = UserDefaults.standard.integer(forKey: "selectedGameId")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        
        
        likeButton.setImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        
        
        textView.isEditable = false
        textView.textAlignment = .justified
        
        
        
        ApiService().fetchGameDetail(id: selectedGameId) { (gameDetail) in
            
            let imageUrl = URL(string: "\(gameDetail.background_image)")
            
            if let url = imageUrl{
                
                self.imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
            }
            self.gameName.text = gameDetail.name
            self.releasedDate.text = gameDetail.released
            self.metacriticRate.text = String(gameDetail.metacritic)
            self.textView.text = gameDetail.description
            
        }
    }
    
    @objc func doneButton(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func like(){
        
        if !likeButtonClicked{
            
            likeButton.setImage(#imageLiteral(resourceName: "thumb-fill"), for: .normal)
            likeButtonClicked = true
            let favorietedGameId = UserDefaults.standard.integer(forKey: "selectedGameId")
            //UserDefaults.standard.set(favorietedGameId, forKey: "favoriteGameId")
            FavoriteViewController.favArray.append(favorietedGameId)
        
        }else{
            
            likeButton.setImage(#imageLiteral(resourceName: "thumb"), for: .normal)
            likeButtonClicked = false
        }

    }

}
