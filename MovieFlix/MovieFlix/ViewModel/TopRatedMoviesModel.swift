//
//  TopRatedMoviesModel.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 17/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import Foundation
class TopRatedMoviesModel{
    var sourceViewModels :[MoviesViewModel] = [MoviesViewModel]()
    var bindToSourceViewModels :(() -> ()) = {  }
    
    func getMovies(url : String) {
        WebService.shared.getRequest(urlString: url) { (json, response, error) in
            let decoder = JSONDecoder()
            do {
                let movies = try decoder.decode(TopRated.self, from: json ?? Data())
                self.sourceViewModels = movies.results.compactMap({ (results) in
                    return MoviesViewModel.init(source: results)
                }) ?? []
                self.bindToSourceViewModels()
            }  catch {
                print("error: ", error.localizedDescription)
            }
        }
    }
}
