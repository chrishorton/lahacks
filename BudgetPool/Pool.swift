//
//  Pools.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import Foundation

struct Pool {
	var id : String = ""
	var name : String = ""
	var contribution : Int = 0
	var intervalInDays : Int = 0
	var memberIds : [String] = [String]()
	
	init(id: String,
		name : String,
		contribution : Int,
		intervalInDays : Int,
		memberIds: [String]) {
		self.id = id
		self.name = name
		self.contribution = contribution
		self.intervalInDays = intervalInDays
		self.memberIds = memberIds
	}
	
	init() {
		
	}
}
