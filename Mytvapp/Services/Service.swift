//
//  Service.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 21/12/22.
//

import UIKit
import Alamofire

let queryParams = ["api_key": "e0ce189acf3d2d79bfe632aa8bbe92b8", "language":"en-US"]
let baseMoviesUrl = "https://api.themoviedb.org/3/tv/"

func getMoviesRequest(withMovieCategory category: String, success:@escaping (Shows) -> Void, failure:@escaping (Error) -> Void) {
    let movieUrl = baseMoviesUrl + category
    let request = AF.request(movieUrl, method: .get, parameters: queryParams)
    
    request.responseDecodable(of: Shows.self){ (response) in
        if response.error == nil {
            success(response.value!)
        }
        if response.error != nil{
            let error : Error = response.error!
            _ = ["NSLocalizedDescription" : error.localizedDescription]
            failure(error)
        }
        
    }
}

func getRequestToken() {
    let request = AF.request("https://api.themoviedb.org/3/authentication/token/new", method: .get, parameters: queryParams)
    request.responseDecodable(of: Token.self){ (response) in
        if response.error == nil {
            Session.shared.saveToken(password:  response.value!.token)
        }
        if response.error != nil{
            let error : Error = response.error!
            _ = ["NSLocalizedDescription" : error.localizedDescription]
            
            debugPrint(error)
        }
        
    }
    
}

func login(userName: String, password: String, success:@escaping (Token) -> Void, failure:@escaping (Error) -> Void) {
    
    let params = [
        "username": userName,
        "password": password,
        "request_token": Session.shared.getToken(),
    ]
    
    
    let request = AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=e0ce189acf3d2d79bfe632aa8bbe92b8", method: .post, parameters: params, encoding: URLEncoding(destination: .queryString))
    
    request.responseDecodable(of: Token.self){ (response) in
        if response.error == nil {
            success(response.value!)
        }
        if response.error != nil{
            let error : Error = response.error!
            _ = ["NSLocalizedDescription" : error.localizedDescription]
            debugPrint(response.error)
            debugPrint(response)
            failure(error)
        }
    }
    
    
}
