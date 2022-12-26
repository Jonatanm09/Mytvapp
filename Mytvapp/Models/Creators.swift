//
//  Creators.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 25/12/22.
//

struct Creators: Codable {
    let id: Int?
    let name: String?
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "profile_path"
    }
    
}
