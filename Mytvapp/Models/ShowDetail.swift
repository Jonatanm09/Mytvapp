//
//  ShowDetail.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 23/12/22.
//

struct ShowDetail: Decodable {
    let id: Int
    let createdBy:[[String:String]]
    let name: String
    let overview: Float
    let photo : String

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdBy = "created_by"
        case overview = "overview"
        case name = "name"
        case photo =  "poster_path"
    }
}
