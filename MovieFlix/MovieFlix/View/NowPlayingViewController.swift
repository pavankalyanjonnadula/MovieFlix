//
//  NowPlayingViewController.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 16/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    @IBOutlet weak var nowPlayingMoviesCollectionView: UICollectionView!
    lazy var viewModel : PlayNowMoviesViewModel = {
        let viewModel = PlayNowMoviesViewModel()
        return viewModel
    }()
    private var dataSource : CollectionViewDataSource!
    private let refreshControl = UIRefreshControl()
    let search = UISearchController(searchResultsController: nil)
    var duplicateMoviesModel = [MoviesViewModel]()
    
    //MARK: ViewContaoller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingMoviesCollectionView.register(UINib.init(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviescell")
        getMovies()
        
        nowPlayingMoviesCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        addSaerchNow(search: search)
        search.searchResultsUpdater = self
    }
    @objc private func refreshData(_ sender: Any) {
        getMovies()
    }
    func getMovies(){
        SKProgressView.shared.showProgressView(self.view)
        viewModel.getMovies(url : ApiUrls.nowPlayingMovies)
        self.viewModel.bindToSourceViewModels = {
            self.refreshControl.endRefreshing()
            self.updateDataSource(movieModels: self.viewModel.sourceViewModels)
            SKProgressView.shared.hideProgressView()
        }
    }

    func updateDataSource(movieModels : [MoviesViewModel]) {
        self.dataSource = CollectionViewDataSource(items: movieModels, view: self.view, vc: self)
        self.dataSource.deleteMainModel = { index in
            self.remove(index: index)
        }
        self.nowPlayingMoviesCollectionView.dataSource = self.dataSource
        self.nowPlayingMoviesCollectionView.delegate = self.dataSource
        self.nowPlayingMoviesCollectionView.reloadData()
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
        nowPlayingMoviesCollectionView.performBatchUpdates({
            self.nowPlayingMoviesCollectionView.deleteItems(at: [indexPath])
        }, completion: {
            (finished: Bool) in
            self.nowPlayingMoviesCollectionView.reloadItems(at: self.nowPlayingMoviesCollectionView.indexPathsForVisibleItems)
        })
    }

}

extension NowPlayingViewController: UISearchResultsUpdating {
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
