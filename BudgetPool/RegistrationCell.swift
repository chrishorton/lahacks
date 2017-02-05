

import UIKit

enum RegistrationCellType: Int {
	case email = 0
	case password
}

class RegistrationCell: UITableViewCell, UITextFieldDelegate {
	
	var delegate : RegistrationCellDelegate?
	var type : RegistrationCellType!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	var isThirdDigit = false
	var isEditingHeight = false
	
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

}

protocol RegistrationCellDelegate {
	func didUpdateCellEntry(_ type: RegistrationCellType, text: String)
}
