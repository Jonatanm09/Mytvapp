//
//  Episodes.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 25/12/22.
//

struct Episodes: Decodable {
    
    let seasonNumber: Int?
    let episodseCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case seasonNumber = "season_number"
        case episodseCount = "episode_count"
    }
}
