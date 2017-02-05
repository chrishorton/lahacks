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

	var isLogin = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//Services.createPool(uuid: UUID().uuidString)
		//let email = encodeAsFirebaseKey(string: "joe@gmail.com")
		//Services.createUser(email: email, password: "test")
		//Services.fetchPools(userEmail: email)
		//print(Services.loginUser(email: "suppboy", password: "jks"))
	}
	
	func encodeAsFirebaseKey(string : String) -> String {
		return string.replacingOccurrences(of: ".", with: "%2E")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func register() {
		isLogin = false
		self.performSegue(withIdentifier: "toRegistration", sender: nil)
	}
	
	@IBAction func login() {
		isLogin = true
		self.performSegue(withIdentifier: "toRegistration", sender: nil)
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? RegistrationViewController {
			dest.isLogin = self.isLogin
		}
    }

}


