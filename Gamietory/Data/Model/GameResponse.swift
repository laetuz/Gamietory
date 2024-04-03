//
//  GameResponse.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import Foundation

struct GameResponse: Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Results]?
    let noindex : Bool?
    let nofollow : Bool?
    let description : String?
   

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
struct Results : Codable, Identifiable {
    let id : Int?
    let slug : String?
    let name : String?
    let released : String?
    let tba : Bool?
    let background_image : String?
    let rating : Double?
    let rating_top : Int?
 
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case slug = "slug"
        case name = "name"
        case released = "released"
        case tba = "tba"
        case background_image = "background_image"
        case rating = "rating"
        case rating_top = "rating_top"
    }
}
