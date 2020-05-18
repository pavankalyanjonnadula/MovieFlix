//
//  DeatilsVC.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 17/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit

class DeatilsVC: UIViewController {

    @IBOutlet weak var bottomConstarit: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    var model : MoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalizeVC()
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(respondToGesture))
        swipeUP.direction = .up
        bottomView.addGestureRecognizer(swipeUP)
        bottomConstarit.constant = -30
    }
    @objc func respondToGesture(){
        if bottomConstarit.constant == -30{
            bottomConstarit.constant = 15
        }
    }
    
    func initalizeVC(){
        detailsImage.downloadImage(from: URL(string: model.poster)!)
        titleLabel.text = model.title
        overViewLabel.text = model.overView
    }
}
