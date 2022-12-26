//
//  Movie.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 21/12/22.
//


struct Show: Codable {
    var id: Int
    var title: String
    var releaseDate: String
    var calification: Float
    var photo : String
    var description : String
    var category: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "original_name"
        case releaseDate = "first_air_date"
        case calification = "vote_average"
        case photo =  "poster_path"
        case description = "overview"
        case category = ""
    }
}
