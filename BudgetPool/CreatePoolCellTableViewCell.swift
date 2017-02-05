//
//  CreatePoolCellTableViewCell.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/5/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import UIKit

enum CreateCellType: Int {
	case name = 0
	case contribution
	case interval
	case member
	
	static let count: Int = {
		var max: Int = 0
		while let _ = CreateCellType(rawValue: max) { max += 1 }
		return max
	}()
}

class CreatePoolCellTableViewCell: UITableViewCell, UITextFieldDelegate {

	var type : CreateCellType!
	var delegate : CreateCellDelegate?
	@IBOutlet weak var textField: UITextField!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.textField.delegate = self
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		if selected {
			textField.becomeFirstResponder()
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		delegate?.didUpdateCellEntry(type, text: textField.text!)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}

protocol CreateCellDelegate {
	func didUpdateCellEntry(_ type: CreateCellType, text: String)
}


