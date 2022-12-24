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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        self.indicatorLogin.startAnimating()
        
        if !userTexfield.text!.isEmpty  && !userPasswordField.text!.isEmpty && !userTexfield.text!.hasPrefix(" ") && !userTexfield.text!.hasSuffix(" ")  {
            user?.userName = userTexfield.text!
            user?.password = userPasswordField.text!
            
            login(userName: userTexfield.text!, password: userPasswordField.text!) { User in
                self.performSegue(withIdentifier: self.tvShowSegue, sender: self)
            } failure: { Error in
                displayAlert(withTitle: "Error", message: "Hubo un error inesperado", controller: self)
                self.indicatorLogin.stopAnimating()
            }
            setButtonEnable(isEnable: true)
        } else {
            displayAlert(withTitle: "Error", message: "Hubo un error inesperado", controller: self)
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

