//
//  GameResponse.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import Foundation

struct GameResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Results]?
    let noindex: Bool?
    let nofollow: Bool?
    let description: String?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
        case noindex = "noindex"
        case nofollow = "nofollow"
        case description = "description"
    }
}

// MARK: - Result
struct Results: Codable, Identifiable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let shortScreenshots: [ShortScreenshots]


    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case shortScreenshots = "short_screenshots"
    }
}

struct Platforms: Codable {
   // let platform : Platform?
  //  let releasedAt : String?
    let requirementsEn: RequirementsEn?
  //  let requirementsRu : String?

    enum CodingKeys: String, CodingKey {

      //  case platform = "platform"
      //  case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
     //   case requirementsRu = "requirements_ru"
    }
}

struct Platform: Codable {
    let id: Int?
    let name: String?
    let slug: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case slug = "slug"
    }
}

struct RequirementsEn: Codable {
    let minimum: String?
    let recommended: String?

    enum CodingKeys: String, CodingKey {

        case minimum = "minimum"
        case recommended = "recommended"
    }
}

struct ShortScreenshots: Codable, Identifiable {
    let id: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image = "image"
    }
}
