//
//  Movie.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 21/12/22.
//


struct Show: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let calification: Float
    let photo : String
    let description : String

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "original_name"
        case releaseDate = "first_air_date"
        case calification = "vote_average"
        case photo =  "poster_path"
        case description = "overview"
    }
}
