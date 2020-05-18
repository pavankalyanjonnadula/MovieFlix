//
//  CollectionViewDataSource.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 17/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    private var items :[MoviesViewModel]!
    private var view : UIView!
    private var vc : UIViewController
    var deleteMainModel :((Int) -> ()) = { _ in  }

    init(items :[MoviesViewModel],view : UIView,vc : UIViewController) {
        self.items = items
        self.view = view
        self.vc = vc
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = Bundle.main.loadNibNamed("MoviesCollectionViewCell", owner: self, options: nil)?.first as! MoviesCollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviescell", for: indexPath) as! MoviesCollectionViewCell
        cell.movieImageView.downloadImage(from: URL(string: items[indexPath.item].poster)!)
        cell.movieNameLabel.text = items[indexPath.item].title
        cell.movieDescription.text = items[indexPath.item].overView
        cell.deleteButton.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.item
        return cell
    }
    @objc func deleteBtnAction(sender : UIButton){
        let index = sender.tag
        self.items.remove(at: index)
        deleteMainModel(index)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let deatiails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DeatilsVC") as! DeatilsVC
        deatiails.model = items[indexPath.row]
        vc.navigationController?.pushViewController(deatiails, animated: true)
    }

}

