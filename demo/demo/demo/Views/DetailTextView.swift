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
	
	var expand: Bool = false {
		didSet {
			button.setTitle(expand ? "Hide More" : "Show More", forState: .Normal)
			greaterOrEqualToMinConstraint.priority = expand ? 999 : UILayoutPriorityDefaultLow
			lessOrEqualToMinConstraint.priority = expand ? UILayoutPriorityDefaultLow : 999
			UIView.animateWithDuration(1) { () -> Void in
				self.layoutIfNeeded()
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
			button.hidden = true
		} else {
			button.hidden = false
		}
	}
	
	@IBAction func buttonPressed(sender: UIButton) {
		expand = !expand
	}
}
