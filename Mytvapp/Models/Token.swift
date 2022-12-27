//
//  Token.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 22/12/22.
//

struct Token: Decodable {
    let success: Bool
    let expires: String?
    let token: String?
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expires = "expires_at"
        case token = "request_token"
        case statusMessage = "status_message"
    }
}
