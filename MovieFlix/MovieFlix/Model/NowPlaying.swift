//
//  NowPlaying.swift
//
//  Created on May 16, 2020
//
import Foundation

struct NowPlaying: Codable {

    let results: [Results]?
    let page: Int
    let totalResults: Int
    let dates: Dates
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case page = "page"
        case totalResults = "total_results"
        case dates = "dates"
        case totalPages = "total_pages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Results].self, forKey: .results)
        page = try values.decode(Int.self, forKey: .page)
        do{
        totalResults = try values.decode(Int.self, forKey: .totalResults)
        }catch{
            totalResults = 0
        }
        dates = try values.decode(Dates.self, forKey: .dates)
        do{
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        }catch{
            totalPages = 0
        }
    }

}
