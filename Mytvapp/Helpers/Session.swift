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
    
    func getUser() -> User? {
        let decoder = JSONDecoder()
        guard let user = UserDefaults.standard.value(forKey: "user") else {
            return (nil)
        }
        let decodedUser = try! decoder.decode(User.self, from: (user as? Data)! )
        return (decodedUser as User)
    }
    
    func saveUser(user: User){
        let encoder = JSONEncoder()
        let data = try! encoder.encode(user)
        UserDefaults.standard.set(data, forKey: "user")
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
    }
}

