//
//  PlayNowMoviesViewModel.swift
//  MovieFlix
//
//  Created by Pavan Kalyan Jonnadula on 16/05/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import Foundation

class PlayNowMoviesViewModel{
 
    var sourceViewModels :[MoviesViewModel] = [MoviesViewModel]()
    var bindToSourceViewModels :(() -> ()) = {  }

    func getMovies(url : String) {
        WebService.shared.getRequest(urlString: url) { (json, response, error) in
            let decoder = JSONDecoder()
            do {
                let movies = try decoder.decode(NowPlaying.self, from: json ?? Data())
                self.sourceViewModels = movies.results?.compactMap({ (results) in
                    return MoviesViewModel.init(source: results)
                }) ?? []
                self.bindToSourceViewModels()
            }  catch {
                print("error: ", error.localizedDescription)
            }
        }
    }

}



class MoviesViewModel : NSObject {
    
    var title :String
    var overView :String
    var poster : String
    var backDropPoster : String
    var language : String
    var releaseDate : String
    init(source : Results) {
        self.title = source.title
        self.overView = source.overview
        self.poster = "https://image.tmdb.org/t/p/w342" + (source.posterPath ?? "")
        self.backDropPoster = "https://image.tmdb.org/t/p/original" + source.backdropPath
        self.language = source.originalLanguage
        self.releaseDate = source.releaseDate
    }
}
