//
//  ViewController.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		Services.delegate = self
		Services.createPool(uuid: UUID().uuidString)
		//Services.createUser(email: "supp", password: "jksf")
		
		print(Services.loginUser(email: "supp", password: "jksf"))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    @IBAction func logInButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "logIn", sender: sender)
    }

    @IBAction func SignUpButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "signUp", sender: sender)

    }
    
    var loginIdentifierInitial = " "
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            loginIdentifierInitial = "SignUp"
            let viewController: LoginSignupTextViewController = segue.destination as! LoginSignupTextViewController
            viewController.loginIdentifier = loginIdentifierInitial
        }
        
        if segue.identifier == "logIn" {
            loginIdentifierInitial = "LogIn"
            let viewController: LoginSignupTextViewController = segue.destination as! LoginSignupTextViewController
            viewController.loginIdentifier = loginIdentifierInitial

        }
    }

}

extension ViewController : ServicesDelegate {
	func loginCallback(success: Bool, message: String) {
		print("success", success, "message:", message)
	}
}
