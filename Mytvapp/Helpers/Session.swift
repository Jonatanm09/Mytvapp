//
//  Session.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 20/12/22.
//


import Foundation

class Session {
    static let  shared: Session = Session()
    private init(){}
    
    var user: User? = nil
    
    func saveUserCredentials(userName: String, password: String) {
        UserDefaults.standard.set(userName, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    func userHasSavedCredentials() -> Bool {
        let credentials = self.getUserCredentials()
        if credentials.1 != nil {
            return true
        }
        return false
    }
    
    func saveShows(shows:[Show]){
        let encoder = JSONEncoder()
        let data = try! encoder.encode(shows)
        UserDefaults.standard.set(data, forKey: "shows")
    }
    
    func getShows() -> ([Show])?{
        let decoder = JSONDecoder()
        guard let shows = UserDefaults.standard.value(forKey: "shows") else {
            return (nil)
        }
        let decodedShows = try! decoder.decode([Show].self, from: (shows as? Data)! )
        return (decodedShows as [Show])
    }
    
    func saveCast(cast:[Credits]){
        let encoder = JSONEncoder()
        let data = try! encoder.encode(cast)
        UserDefaults.standard.set(data, forKey: "cast")
    }
    
    func getCast() -> ([Credits])?{
        let decoder = JSONDecoder()
        guard let shows = UserDefaults.standard.value(forKey: "cast") else {
            return (nil)
        }
        let decodedShows = try! decoder.decode([Credits].self, from: (shows as? Data)! )
        return (decodedShows as [Credits])
    }
    
    
    func saveShowDetail(showDetail:ShowDetail){
        var showsSaved : [ShowDetail] = []
        
        showsSaved.append(showDetail)
        let encoder = JSONEncoder()
        let data = try! encoder.encode(showsSaved)
        UserDefaults.standard.set(data, forKey: "showDetail")
    }
    
    func getShowDetail() -> ([ShowDetail])?{
        let decoder = JSONDecoder()
        guard let showDetail = UserDefaults.standard.value(forKey: "showDetail") else {
            return (nil)
        }
        let decodedShowDetail = try! decoder.decode([ShowDetail].self, from: (showDetail as? Data)! )
        return (decodedShowDetail as [ShowDetail])
    }
    
    
    func saveToken(token: String, expires: String) {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(expires, forKey: "expires")
    }
    
    func getUserCredentials() -> (String?, String?) {
        guard let username = UserDefaults.standard.value(forKey: "username"), let password = UserDefaults.standard.value(forKey: "password") else {
            return (nil, nil)
        }
        return (username as? String, password as? String)
    }
    
    func getToken() -> (String?, String? ){
        guard let token = UserDefaults.standard.value(forKey: "token"), let expires = UserDefaults.standard.value(forKey: "expires") else {
            return (nil, nil)
        }
        return(token as? String, expires as? String)
    }
    
    func dispose() {
        self.user = nil
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "expires")
        UserDefaults.standard.removeObject(forKey: "showDetail")
        UserDefaults.standard.removeObject(forKey: "shows")
        UserDefaults.standard.removeObject(forKey: "cast")

    }
}

