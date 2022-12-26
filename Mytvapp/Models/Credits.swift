//
//  Credits.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 25/12/22.
//

import Foundation

struct Credits: Decodable {
    let name: String?
    let characterName: String?
    let profilePhoto: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case characterName = "original_name"
        case profilePhoto = "profile_path"
    }
    
}
