//
//  PageViewController.swift
//  
//
//  Created by Batuhan Baran on 30.01.2021.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let pageControl = UIPageControl()
    var initialPage = 0
    
    
    lazy var subViewControllers:[UIViewController] = {
       
        return [
            
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstItem") as! FirstItem,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondItem") as! SecondItem,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdItem") as! ThirdItem
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        setViewControllerFromIndex(index: 0)
    }
    
    func setViewControllerFromIndex(index:Int) {
        self.setViewControllers([subViewControllers[index]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.subViewControllers.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}

//MARK:- extensions

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.firstIndex(of: viewController) ?? 0
        self.pageControl.currentPage = currentIndex
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.firstIndex(of: viewController) ?? 0
        self.pageControl.currentPage = currentIndex
        if currentIndex >= subViewControllers.count-1 {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
}
