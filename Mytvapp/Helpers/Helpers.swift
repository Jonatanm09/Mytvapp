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



func showSimpleAlert( controller: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
    let alert = UIAlertController(title: "Log out?", message: "Está seguro que desea salir de sesión?",         preferredStyle: UIAlertController.Style.alert)

    alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: { _ in
        //Cancel Action
    }))
    alert.addAction(UIAlertAction(title: "Log out",
                                  style: UIAlertAction.Style.default,
                                  handler: handler))
    controller.present(alert, animated: true, completion: nil)
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self){
            return date;
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let newDate = dateFormatter.date(from: self)
        return newDate;
    }
}

