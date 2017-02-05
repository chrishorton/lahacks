//
//  ViewControllerExtension.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	override open func awakeFromNib() {
		super.awakeFromNib()
		self.view.backgroundColor = orangeColor
	}
	
	func bpNoActionAlert(_ title: String, message: String, completionHandler: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: completionHandler)
		
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
	
}
