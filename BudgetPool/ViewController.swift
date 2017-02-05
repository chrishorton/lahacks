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
		//Services.createPool(uuid: UUID().uuidString)
		Services.createUser(email: "suppboy", password: "jks")
		
		print(Services.loginUser(email: "suppboy", password: "jks"))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension ViewController : ServicesDelegate {
	func loginCallback(success: Bool, message: String) {
		print("success", success, "message:", message)
	}
}
