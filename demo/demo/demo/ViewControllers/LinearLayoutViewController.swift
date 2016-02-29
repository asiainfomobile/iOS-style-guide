//
//  LinearLayoutViewController.swift
//  demo
//
//  Created by admin on 2/29/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit
import SnapKit

class LinearLayoutViewController: UIViewController {
	
	var views = [UIView]()
	var hasLoadedConstraints = false
	var lastConstraint: ConstraintDescriptionEditable!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		for _ in 0 ..< 5 {
			let v = UIView()
			v.backgroundColor = UIColor.redColor()
			v.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(v)
			views.append(v)
		}
		
		let navigationBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonClick")
		navigationItem.rightBarButtonItem = navigationBarButtonItem
	}
	
	func addButtonClick() {
//		let last = views.last!
		let v = UIView()
		v.backgroundColor = UIColor.redColor()
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		views.append(v)
		
		v.layoutIfNeeded()
//        self.lastConstraint.constraint.uninstall()
//        v.snp_makeConstraints { (make) -> Void in
//            make.width.equalTo(last)
//            make.height.equalTo(last)
//            make.centerY.equalTo(last)
//            make.leading.equalTo(last.snp_trailing).offset(10)
//            self.lastConstraint = make.trailing.equalTo(self.view).offset(-10)
//        }
		hasLoadedConstraints = false
		UIView.animateWithDuration(1) { () -> Void in
			self.view.setNeedsUpdateConstraints()
			v.layoutIfNeeded()
		}
	}
	
	override func updateViewConstraints() {
		
		if (!hasLoadedConstraints) {
			hasLoadedConstraints = true;
			
			let margin: CGFloat = 10
			
			var previousView = view
			for i in 0 ..< views.count {
				let v = views[i]
				v.snp_updateConstraints(closure: { (make) -> Void in
					if previousView != view {
						make.width.equalTo(previousView)
						make.leading.equalTo(previousView.snp_trailing).offset(margin)
					} else {
						make.leading.equalTo(view).offset(margin)
					}≤`
					make.centerY.equalTo(previousView)
					make.height.equalTo(100)
					if i == views.count - 1 {
						make.trailing.greaterThanOrEqualTo(view).offset(-margin)
					}
				})
				previousView = v
			}
		}
		super.updateViewConstraints()
	}
}
