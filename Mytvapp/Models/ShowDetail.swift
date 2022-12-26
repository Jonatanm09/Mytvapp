//
//  ShowDetail.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 23/12/22.
//

struct ShowDetail: Decodable {
    let id: Int?
    let creators: [Creators]?
    let name: String?
    let overview: String?
    let photo : String?
    let seasons: [Episodes]?
    let airDate : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case creators = "created_by"
        case overview = "overview"
        case name = "name"
        case photo =  "backdrop_path"
        case seasons = "seasons"
        case airDate = "first_air_date"
    }
}
