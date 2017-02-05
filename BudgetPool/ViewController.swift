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
		
		Services.createPool(uuid: UUID().uuidString)
		Services.createUser(email: "supp", password: "jksf")
		
		print(Services.loginUser(email: "supp", password: "jksf"))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

