//
//  Connectivity.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 26/12/22.
//

import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
