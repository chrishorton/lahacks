//
//  ViewController.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit
import AWSCore
import AWSDynamoDB

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		print("hello")
		Services.authenticate()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

