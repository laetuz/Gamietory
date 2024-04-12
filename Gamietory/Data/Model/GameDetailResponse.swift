//
//  GameDetailResponse.swift
//  Gamietory
//
//  Created by Ryo Martin on 12/04/24.
//

import Foundation

struct GameDetailResponse: Codable {
    let id : Int?
    let slug : String?
    let name: String?
    let nameOriginal: String?
    let description: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case slug = "slug"
        case name = "name"
        case nameOriginal = "name_original"
        case description = "description"
    }
}
