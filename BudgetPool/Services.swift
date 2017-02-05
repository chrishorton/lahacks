//
//  Services.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import Foundation


struct Services {
	
	static var delegate : ServicesDelegate?
	static let loggedOnKey = "isLoggedOn"
	
	static func createPoolOnFB(pool : Pool) {
		ref.child(pool.id).child("members").setValue(pool.memberIds)
		ref.child(pool.id).child("contribution_dollar_amount").setValue(pool.contribution)
		ref.child(pool.id).child("interval_in_days").setValue(pool.intervalInDays)
		//ref.child(uuid).child("").setValue("sup")
	}
	
	//registration
	static func createUser(email: String, password: String) {
		ref.child("users").child(email).setValue(password)
	}
	
	static func fetchPools(userEmail: String) {
		print("GETTING POOLS")
		print("userEmail:", userEmail)
		let values = ref.child("members").queryEqual(toValue: nil, childKey: userEmail)
		values.observe(.value, with: { (snapshot) in
			print(snapshot)
			if let dict = snapshot.value as? NSDictionary {
				let poolIDs = dict[userEmail] as! [String]
				poolsFromPoolIDs(poolIDs: poolIDs)
			}
			else {
				delegate?.getPoolsCallback(success: false, pools: [Pool]())
			}
		})
	}
	
	private static func poolsFromPoolIDs(poolIDs: [String]) {
		gblPools = [Pool]()
		for id in poolIDs {
			let values = ref.child("pools").queryEqual(toValue: nil, childKey: id)
			values.observe(.value, with: { (snapshot) in
				print(snapshot)
				if let dict = snapshot.value as? NSDictionary {
					let poolDict = dict[id] as! NSDictionary
					print(poolDict)
					let name = poolDict["name"] as! String
					let members = poolDict["members"] as! [String]
					let intervalInDays = poolDict["interval_in_days"] as! Int
					let contribution =	poolDict["contribution_dollar_amount"] as! Int
					let poolStruct = Pool(id: id, name: name, contribution: contribution, intervalInDays: intervalInDays, memberIds: members)
					print(poolStruct)
					gblPools.append(poolStruct)
					delegate?.getPoolsCallback(success: true, pools: gblPools)
				}
			})
		}
	}
	
	static func isLoggedOn() -> Bool {
		return UserDefaults.standard.bool(forKey: loggedOnKey)
	}
	
	static func loginUser(email: String, password: String) {
		print(email)
		print(password)
		let values = ref.child("users").queryEqual(toValue: nil, childKey: email)
		print(values)
		values.observe(.value, with: { (snapshot) in
			print(snapshot)
			if snapshot.hasChildren() {
				if let dict = snapshot.value as? NSDictionary {
					let truePassword = dict.value(forKey: email) as! String
					print(truePassword)
					if truePassword == password {
						delegate?.loginCallback(success: true, message: "good job")
						UserDefaults.standard.set(true, forKey: loggedOnKey)
						return
					}
				}
			}
			delegate?.loginCallback(success: false, message: "Invalid login.")
		})
	}
}

protocol ServicesDelegate {
	func loginCallback(success: Bool, message: String)
	func getPoolsCallback(success: Bool, pools : [Pool])
}


