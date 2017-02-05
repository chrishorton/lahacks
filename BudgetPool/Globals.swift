//
//  Globals.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

var ref: FIRDatabaseReference!
var gblPools : [Pool]!
let orangeColor = UIColor(hex: 0xF9A346)
var gblUserEmail = ""

struct Themes {
	static let color0							= UIColor(hex: 0x23272B)
	static let color1							= UIColor(hex: 0xA7A9AA)
	static let color2							= UIColor.white
	static let color3							= UIColor(hex: 0x47C1D8)
	static let color4							= UIColor(red: 211.0/255.0, green: 211.8/255.0, blue: 212.6/255.0, alpha: 1.0)
	static let color5							= UIColor(hex: 0xFF5A59)
	static let color6							= UIColor(red: 167.0/255.0, green: 168.6/255.0, blue: 170.2/255.0, alpha: 1.0)
	static let color7							= UIColor(red: 189.0/255.0, green: 190.2/255.0, blue: 191.4/255.0, alpha: 1.0)
	static let color8							= UIColor(hex: 0x232323)
	static let color9							= UIColor(hex: 0xE9E9E9)
	
	static let font0Name						= "TradeGothicLTStd-BdCn20"
	static let font1Name						= "Graphik-Regular"
	static let font2Name						= "Graphik-Medium"
	static let font3Name						= "Graphik-Semibold"
	
	static let batteryColorFull					= UIColor(hex: 0x48D7C1)
	static let batteryColorMedium				= UIColor(hex: 0xF9A346)
	static let batteryColorLow					= Themes.color5
	static let batteryThresholdFull				= Int(50)
	static let batteryThresholdMedium			= Int(25)
	
	static let genericLabelColor				= Themes.color0
	static let genericLabelFontName				= Themes.font1Name
	static let genericLabelSize					= CGFloat(15.0)
	
	static let titleLabelColor					= Themes.color0
	static let titleFont						= Themes.font0Name
	
	static let biostrapBlack					= Themes.color8
	
	static let subtitleLabelColor				= Themes.color1
	static let subtitleLabelFontName			= Themes.font1Name
	static let buttonBorderColor				= Themes.color1
	
	static let fadedLabelColor					= Themes.color1
	static let fadedLabelFontName				= Themes.font1Name
}
