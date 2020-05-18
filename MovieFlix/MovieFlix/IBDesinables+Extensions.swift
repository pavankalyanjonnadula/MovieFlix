//
//  IBDesinables.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 16/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit
@IBDesignable extension UINavigationController {
    @IBInspectable var barTintColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            navigationBar.barTintColor = uiColor
        }
        get {
            guard let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
}


extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}


extension UIViewController{
    func addSaerchNow(search : UISearchController){
        search.searchBar.placeholder = "Search"
        search.searchBar.backgroundColor = UIColor.clear
        search.obscuresBackgroundDuringPresentation = false

        search.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = search
    }
}
extension TopRatedViewController{
    func addSaerchTop(search : UISearchController){
        search.searchBar.placeholder = "Search"
        search.searchBar.backgroundColor = UIColor.clear
        search.obscuresBackgroundDuringPresentation = false

        search.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = search.searchBar
    }
}
