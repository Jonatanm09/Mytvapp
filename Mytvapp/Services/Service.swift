//
//  Service.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 21/12/22.
//

import UIKit
import Alamofire

let queryParams = ["api_key": "e0ce189acf3d2d79bfe632aa8bbe92b8", "language":"en-US"]
let baseMoviesUrl = "https://api.themoviedb.org/3/tv"
let baseImgUrl = "https://themoviedb.org/t/p"
let imageUrl = baseImgUrl + "/w600_and_h900_bestv2"
let faceUrl = baseImgUrl + "/w116_and_h174_face"
let headerImgUrl = baseImgUrl + "/w1920_and_h800_multi_faces"

func getMoviesRequest(withMovieCategory category: String, success:@escaping (Shows) -> Void, failure:@escaping (Error) -> Void) {
    let movieUrl = baseMoviesUrl + "/\(category)"
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

func getShowsDetailsRequest(withId showId: Int, success:@escaping (ShowDetail) -> Void, failure:@escaping (Error) -> Void){
    let movieUrl = baseMoviesUrl + "/\(showId)"
    let request = AF.request(movieUrl, method: .get, parameters: queryParams)
    
    request.responseDecodable(of: ShowDetail.self){ (response) in
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

func getCredits(withId tvId: Int, success:@escaping (Cast) -> Void, failure:@escaping (Error) -> Void){
    let movieUrl = baseMoviesUrl + "/\(tvId)/credits"
    let request = AF.request(movieUrl, method: .get, parameters: queryParams)
    
    request.responseDecodable(of: Cast.self){ (response) in
        if response.error == nil {
            success(response.value!)
            Session.shared.saveCast(cast: response.value!.cast)
        }
        if response.error != nil{
            let error : Error = response.error!
            _ = ["NSLocalizedDescription" : error.localizedDescription]
            failure(error)
        }
        
        
    }
}

func getRequestToken(success:@escaping (String) -> Void, failure: @escaping(String) -> Void) {
    let request = AF.request("https://api.themoviedb.org/3/authentication/token/new", method: .get, parameters: queryParams)
    request.responseDecodable(of: Token.self){ (response) in
        if response.error == nil {
            success(response.value!.token!)
            Session.shared.saveToken(token:  response.value!.token!, expires: response.value!.expires!)
        }
        if response.error != nil{
            failure("No se pudo conseguir el token, intentelo mas tarde")
        }
        
    }
    
}

func login(user: User, token: String, success:@escaping (Token) -> Void, failure:@escaping (String) -> Void) {
    
    let params = [
        "username": user.userName,
        "password": user.password,
        "request_token": token,
    ]
    
    
    let request = AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=e0ce189acf3d2d79bfe632aa8bbe92b8", method: .post, parameters: params, encoding: URLEncoding(destination: .queryString))
    
    request.responseDecodable(of: Token.self){ (response) in
        switch response.result {
        case .success(let responseData):
            if response.value?.statusMessage != nil {
                failure(responseData.statusMessage!)
            } else{
                Session.shared.saveUserCredentials(userName: user.userName ,password: user.password)
                success(responseData)
            }
            
        case .failure(let error):
            failure(error.localizedDescription)
        }
    }
    
}


func getImages(imageUrlPath: String, imgType: ImgTypes, img:@escaping (UIImage) -> Void) {
    
    var url = ""
    if imageUrlPath != "" {
        switch imgType {
        case .small:
            url = faceUrl + imageUrlPath
        case .medium:
            url = imageUrl + imageUrlPath
        case .large:
            url = headerImgUrl + imageUrlPath
        }
        AF.request( url, method: .get, parameters: queryParams).response { response in
            
            switch response.result {
            case .success(let responseData):
                img(UIImage(data: responseData!, scale:1)!)
                
            case .failure(_):
                img(UIImage(named: "loki")!)
            }
        }
    }
    
}
