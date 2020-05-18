//
//  Results.swift
//
//  Created on May 16, 2020
//
import Foundation

struct Results: Codable {

    let popularity: Double?
    var voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String

    private enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case posterPath = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try values.decode(Double.self, forKey: .popularity)
        do{
            voteCount = try values.decode(Int?.self, forKey: .voteCount)
        }catch{
            voteCount = 0
        }
        video = try values.decode(Bool.self, forKey: .video)
        do{
            
            posterPath = try values.decode(String.self, forKey: .posterPath)
        }catch{
            posterPath = ""
        }
        do{
            id = try values.decode(Int.self, forKey: .id)
        }catch{
            id = 0
        }
        do{
            adult = try values.decode(Bool.self, forKey: .adult)
        }catch{
            adult = false
        }
        do{
            backdropPath = try values.decode(String.self, forKey: .backdropPath)
            
        }catch{
            backdropPath = ""
        }
        do{
            originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
        }catch{
            originalLanguage = ""
        }
        do{
            originalTitle = try values.decode(String.self, forKey: .originalTitle)
        }catch{
            originalTitle = ""
        }
        do{
            genreIds = try values.decode([Int].self, forKey: .genreIds)
        }catch{
            genreIds = []
        }
        do{
            title = try values.decode(String.self, forKey: .title)
        }catch{
            title = ""
        }
        do{
            voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        }
        catch{
            voteAverage = 0.0
        }
        do{
            overview = try values.decode(String.self, forKey: .overview)
        }
        catch{
            overview = ""
        }
        do{
            releaseDate = try values.decode(String.self, forKey: .releaseDate)
        }catch{
            releaseDate = ""
        }
    }

}
