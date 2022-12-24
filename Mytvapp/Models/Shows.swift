//
//  Movies.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 21/12/22.
//

struct Shows: Decodable {
  let page: Int
  let all: [Show]
  
  enum CodingKeys: String, CodingKey {
    case page = "page"
    case all = "results"
  }
}
