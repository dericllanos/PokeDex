//
//  PageResult.swift
//  Pokedex
//
//  Created by Frederic Rey Llanos on 09/05/2022.
//

import Foundation

struct PageResult: Decodable {
    let count: Int?
    let results: [BasicData]
    let next: String?
    let previous: String?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
        case previous = "previous"
        case count, results
    }
    
}

