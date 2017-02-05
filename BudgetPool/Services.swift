//
//  Services.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import Foundation


struct Services {
	
	static func createPool(uuid: String) {
		ref.child(uuid).child("members").setValue(["sup@gmail.com", "bob@gmail.com", "joe@gmail.com"])
		ref.child(uuid).child("contribution_dollar_amount").setValue(100)
		ref.child(uuid).child("interval_in_days").setValue(7)
		//ref.child(uuid).child("").setValue("sup")
	}
}
