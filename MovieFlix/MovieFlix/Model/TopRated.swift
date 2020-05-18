//
//  TopRated.swift
//
//  Created on May 16, 2020
//
import Foundation

struct TopRated: Codable {
	let page: Int
	let totalResults: Int
	let totalPages: Int
	let results: [Results]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            page = try values.decode(Int.self, forKey: .page)
        }catch{
            page = 0
        }
        do{
            totalResults = try values.decode(Int.self, forKey: .totalResults)
        }catch{
            totalResults = 0
        }
        do{
            totalPages = try values.decode(Int.self, forKey: .totalPages)
        }catch{
            totalPages = 0
        }
        results = try values.decode([Results].self, forKey: .results)
    }
}
