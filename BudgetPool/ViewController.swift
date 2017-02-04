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
	var ref: FIRDatabaseReference!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		ref = FIRDatabase.database().reference()
		self.ref.child("order").mut
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

