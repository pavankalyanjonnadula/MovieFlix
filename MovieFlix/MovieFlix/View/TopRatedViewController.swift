//
//  TopRatedViewController.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 16/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit

class TopRatedViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var topRatedNavigationItem: UINavigationItem!
    @IBOutlet weak var topRatedMoviesCollectionView: UICollectionView!
    lazy var viewModel : TopRatedMoviesModel = {
        let viewModel = TopRatedMoviesModel()
        return viewModel
    }()
    var duplicateMoviesModel = [MoviesViewModel]()
    private var dataSource : CollectionViewDataSource!
    let search = UISearchController(searchResultsController: nil)
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topRatedMoviesCollectionView.register(UINib.init(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviescell")
        getMovies()
        addSaerchNow(search: search)
        search.searchResultsUpdater = self
        topRatedMoviesCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    @objc private func refreshData(_ sender: Any) {
        getMovies()
    }
    func getMovies(){
        SKProgressView.shared.showProgressView(self.view)
        viewModel.getMovies(url : ApiUrls.topRatedMovies)
        self.viewModel.bindToSourceViewModels = {
            self.refreshControl.endRefreshing()
            self.updateDataSource(movieModels: self.viewModel.sourceViewModels)
            SKProgressView.shared.hideProgressView()
        }
    }
    func updateDataSource(movieModels : [MoviesViewModel]) {
        self.dataSource = CollectionViewDataSource(items: movieModels, view: self.view,vc: self)
        self.dataSource.deleteMainModel = { index in
            self.remove(index: index)
        }
        self.topRatedMoviesCollectionView.dataSource = self.dataSource
        self.topRatedMoviesCollectionView.delegate = self.dataSource
        self.topRatedMoviesCollectionView.reloadData()
    }
    
    func remove(index: Int) {
        if duplicateMoviesModel.count > 0{
            let item = duplicateMoviesModel[index]
            duplicateMoviesModel.remove(at: index)
            let deleteMovieAt = viewModel.sourceViewModels.filter { (moviemodel) -> Bool in
                if moviemodel.title.contains(item.title){
                    return false
                }
                return true
            }
            self.viewModel.sourceViewModels = deleteMovieAt

        }
        else{
            self.viewModel.sourceViewModels.remove(at: index)
        }

        let indexPath = IndexPath(row: index, section: 0)
        topRatedMoviesCollectionView.performBatchUpdates({
            self.topRatedMoviesCollectionView.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.topRatedMoviesCollectionView.reloadItems(at: self.topRatedMoviesCollectionView.indexPathsForVisibleItems)
        })
    }
}

extension TopRatedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            duplicateMoviesModel = self.viewModel.sourceViewModels
            filterMoviesAccordingToSearchText(text: text)
        }else{
            duplicateMoviesModel.removeAll()

            updateDataSource(movieModels: self.viewModel.sourceViewModels)
        }
    }
    func filterMoviesAccordingToSearchText(text : String){
        let filteredMovies = duplicateMoviesModel.filter { (moviemodel) -> Bool in
            if moviemodel.title.contains(text){
                return true
            }
            return false
        }
        duplicateMoviesModel = filteredMovies
        updateDataSource(movieModels: filteredMovies)
    }
}



