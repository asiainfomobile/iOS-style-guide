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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		for _ in 0 ..< 2 {
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
		let v = UIView()
		v.backgroundColor = UIColor.redColor()
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		views.append(v)
		
		v.layoutIfNeeded()
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
				v.snp_remakeConstraints(closure: { (make) -> Void in
					if previousView != view {
                        // not the first one
						make.top.equalTo(previousView.snp_bottom).offset(margin)
					} else {
                        // the first one
						make.top.equalTo(view).offset(80)
					}
					make.centerX.equalTo(previousView)
					make.width.equalTo(100)
                    make.height.equalTo(100)

			})
				previousView = v
			}
		}
		super.updateViewConstraints()
	}
}
