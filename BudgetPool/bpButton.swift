
import UIKit

class bpButton: UIButton {

	fileprivate var _isCallToAction	: Bool	= false

	override func awakeFromNib() {
		super.awakeFromNib()
		self.applyTheme()
	}
	
	func applyTheme() {
		//gblLogging.warning ("Applying Theme: isCallToAction = \(isCallToAction)")\
		let color = UIColor.white
		
		self.titleLabel?.font		= UIFont(name: Themes.titleFont, size: 16.0)
		
		let title					= self.title(for: UIControlState())
		let attributedTitle			= NSAttributedString(string: title!.uppercased(), attributes: [NSKernAttributeName: 0.4, NSForegroundColorAttributeName : color])
		self.setAttributedTitle(attributedTitle, for: UIControlState())
		
		let layer					= self.layer
		layer.borderColor			= Themes.buttonBorderColor.cgColor
		layer.borderWidth			= CGFloat(1)
	}
}
