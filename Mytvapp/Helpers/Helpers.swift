//
//  Helpers.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 20/12/22.
//

import UIKit


func displayAlert(withTitle title: String, message: String, controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default)
    alert.addAction(okAction)
    controller.present(alert, animated: true)
}


