//
//  DetailTextView.swift
//  demo
//
//  Created by admin on 3/2/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class DetailTextView: UIView {
	@IBOutlet var view: UIView!
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var button: UIButton!
	
	@IBOutlet weak var lessOrEqualToMinConstraint: NSLayoutConstraint!
	@IBOutlet weak var greaterOrEqualToMinConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var constraintBetweenLabelAndSelf: NSLayoutConstraint!
	var text: String? = nil {
		didSet {
			label.text = text
			layoutIfNeeded()
		}
	}
	
	var expand: Bool = false {
		didSet {
			button.setTitle(expand ? "Hide More" : "Show More", forState: .Normal)
			greaterOrEqualToMinConstraint.priority = expand ? 999 : UILayoutPriorityDefaultLow
			lessOrEqualToMinConstraint.priority = expand ? UILayoutPriorityDefaultLow : 999
			layoutIfNeeded()
		}
	}
	
	var hideMoreButton: Bool = false {
		willSet {
			if hideMoreButton != newValue {
				if newValue {
					constraintBetweenLabelAndSelf.priority = 999
					button.hidden = true
				} else {
					constraintBetweenLabelAndSelf.priority = UILayoutPriorityDefaultLow
					button.hidden = false
				}
				layoutIfNeeded()
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupNibView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupNibView()
	}
	
	func setupNibView() {
		NSBundle.mainBundle().loadNibNamed("DetailTextView", owner: self, options: nil)
		self.addSubview(self.view)
		self.view.snp_makeConstraints { (make) -> Void in
			make.edges.equalTo(self)
		}
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		if CGRectGetHeight(label.frame) < 73 {
			hideMoreButton = true
		} else {
			hideMoreButton = false
		}
	}
	
	@IBAction func buttonPressed(sender: UIButton) {
		expand = !expand
	}
}
