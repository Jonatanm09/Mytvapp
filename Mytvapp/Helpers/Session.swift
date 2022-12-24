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

    func saveUserCredentials(password: String) {
        UserDefaults.standard.set(self.user?.userName, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(password, forKey: "token")
    }
    
    func saveToken(password: String) {
        UserDefaults.standard.set(password, forKey: "token")
    }

    func getUserCredentials() -> (String?, String?) {
        guard let username = UserDefaults.standard.value(forKey: "username"), let password = UserDefaults.standard.value(forKey: "password") else {
            return (nil, nil)
        }
      

        return (username as? String, password as? String)
    }
    func getToken() -> String {
        return UserDefaults.standard.value(forKey: "token") as! String
    }

    func dispose() {
        self.user = nil
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
    }
}
      
