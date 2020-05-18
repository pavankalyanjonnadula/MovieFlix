//
//  Dates.swift
//
//  Created on May 16, 2020
//
import Foundation

struct Dates: Codable {
	let maximum: String
	let minimum: String
    private enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        maximum = try values.decode(String.self, forKey: .maximum)
        minimum = try values.decode(String.self, forKey: .minimum)
    }
}
