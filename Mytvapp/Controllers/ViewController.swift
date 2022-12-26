//
//  ViewController.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 20/12/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var userTexfield: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var indicatorLogin: UIActivityIndicatorView!
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK: Variables
    private  let tvShowSegue = "goToTvShows"
    var user: User?
    override func viewDidLoad() {
        loginBtn.setTitle("Iniciar Sesión", for: .normal)
        loginBtn.tintColor = UIColor.orange
        setButtonEnable(isEnable: false)
        getRequestToken()
        super.viewDidLoad()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        self.indicatorLogin.startAnimating()
        
        if !userTexfield.text!.isEmpty  && !userPasswordField.text!.isEmpty && !userTexfield.text!.hasPrefix(" ") && !userTexfield.text!.hasSuffix(" ")  {
            user?.userName = userTexfield.text!
            user?.password = userPasswordField.text!
            self.setButtonEnable(isEnable: false)
            
            login(userName: userTexfield.text!, password: userPasswordField.text!) { User in
                self.performSegue(withIdentifier: self.tvShowSegue, sender: self)
                self.userTexfield.text = ""
                self.userPasswordField.text = ""
                self.indicatorLogin.stopAnimating()
            } failure: { error in
                displayAlert(withTitle: "Error", message: error, controller: self)
                self.indicatorLogin.stopAnimating()
                self.setButtonEnable(isEnable: true)
            }
        } else {
            displayAlert(withTitle: "Error", message: "El usuario o contraseña no pueden tener espacios en blancos o estar vacios", controller: self)
            self.indicatorLogin.stopAnimating()
            setButtonEnable(isEnable: true)
        }
        
    }
    
    func setButtonEnable(isEnable: Bool) {
        loginBtn.isEnabled = isEnable
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            
            setButtonEnable(isEnable: true)
        }else{
            setButtonEnable(isEnable: false)
        }
    }
}

