//
//  FirsItem.swift
// 
//
//  Created by Batuhan Baran on 30.01.2021.
//

import UIKit
import SDWebImage

class FirstItem: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let itemImage = UserDefaults.standard.string(forKey: "item1Image"){
            
            let imageUrl = URL(string: itemImage)

            if let url = imageUrl{
                
                imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
            }
        }
        
        else{
            
            imageView.image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        

    }


}
