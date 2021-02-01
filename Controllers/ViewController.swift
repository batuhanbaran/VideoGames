//
//  ViewController.swift
//  AppcentAssignment
//
//  Created by Batuhan Baran on 29.01.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    
    
    var testPVC:PageViewController!
    var gameResult = [GameResults]()
    
    var filteredGameResult = [GameResults]()
    var searchActive = false
    var lbl = UILabel()
    
    override func viewDidLoad() {
        
        //searchBar delegate
        
        searchBar.delegate = self
        
        //calling api
        ApiService().fetchData { (games) in
            
            for result in games.results{
                
                self.gameResult.append(result)

            }
            

            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
            
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredGameResult = gameResult
        
        if (searchBar.searchTextField.text != ""){
                
            self.searchActive = true
            containerHeight.constant = 0.0
            containerView.layoutIfNeeded()
            
            
            //filtering
            
            filteredGameResult = gameResult.filter({ $0.name.lowercased().contains(searchText.lowercased())})
            self.collectionView.reloadData()
            
        }else{
            
            lbl.removeFromSuperview()
            self.searchActive = false
            containerHeight.constant = 220.0
            containerView.layoutIfNeeded()
            
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if searchActive{
            
            if filteredGameResult.count == 0{
                
                self.collectionView.isHidden = true
                
                
                self.view.addSubview(lbl)
                
                lbl.text = "Üzgünüz, aradığınız oyun bulunamadı!"
                lbl.font = .systemFont(ofSize: 15)
                lbl.textColor = .systemGray
                
                lbl.translatesAutoresizingMaskIntoConstraints = false
                
                lbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                lbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                
            }else{
                
                self.collectionView.isHidden = false
                lbl.removeFromSuperview()
                return filteredGameResult.count
            }
            
        }
        
        
        if !searchActive{
            
            return gameResult.count - 3
        }
        
        return Int()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    
    
        if !searchActive{
            
            cell.gameName.text = gameResult[indexPath.row + 3].name
            cell.gameRatingReleasing.text = String(gameResult[indexPath.row + 3].rating) + " / " + gameResult[indexPath.row].released

            let imageUrl = URL(string: "\(gameResult[indexPath.row + 3].background_image)")
            
            if let url = imageUrl{
                
                cell.gameImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
            }
        }
        
        else{
            
            cell.gameName.text = filteredGameResult[indexPath.row].name
            cell.gameRatingReleasing.text = String(filteredGameResult[indexPath.row].rating) + "-" + filteredGameResult[indexPath.row].released

            let imageUrl = URL(string: "\(filteredGameResult[indexPath.row].background_image)")
            
            if let url = imageUrl{
                
                cell.gameImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"))
            }
        }
        
        //Handling image of top three item to show in UIPageViewController...
        UserDefaults.standard.setValue(self.gameResult[0].background_image, forKey: "item1Image")
        UserDefaults.standard.setValue(self.gameResult[1].background_image, forKey: "item2Image")
        UserDefaults.standard.setValue(self.gameResult[2].background_image, forKey: "item3Image")
        
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
 
        if searchActive{

            UserDefaults.standard.set(filteredGameResult[indexPath.row].id, forKey: "selectedGameId")


        }else{

            UserDefaults.standard.set(gameResult[indexPath.row + 3].id, forKey: "selectedGameId")
        }

        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
    
    }

}
