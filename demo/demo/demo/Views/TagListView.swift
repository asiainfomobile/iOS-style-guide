//
//  TagListView.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class TagListView: UIView {
	
	var tags: [String]! {
		didSet {
			renderTags()
		}
	}
	var labels = [UILabel]()
	var indexOfFirstLabelInOneLine = [Int]()
	var margin: CGFloat = 10
	var lineSpacing: CGFloat = 10
	
	init(tags: [String]) {
		super.init(frame: .zero)
		self.tags = tags
	}
	
	override func didMoveToSuperview() {
		renderTags()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func renderTags() {
		labels.forEach { (label) -> () in
			label.removeFromSuperview()
		}
		labels.removeAll()
		for (i, tag) in tags.enumerate() {
			let label = UILabel(frame: .zero)
			label.backgroundColor = UIColor.greenColor()
			label.text = tag
			label.tag = i
			addSubview(label)
			labels.append(label)
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		for (i, label) in labels.enumerate() {
			if CGRectGetMaxX(label.frame) > CGRectGetWidth(frame) {
				if !indexOfFirstLabelInOneLine.contains(i) {
					indexOfFirstLabelInOneLine.append(i)
					self.setNeedsUpdateConstraints()
					super.layoutSubviews()
					break
				}
			}
		}
	}
	
	override func updateConstraints() {
		var previousView: UIView! = self
		for label in labels {
			label.snp_remakeConstraints(closure: { (make) -> Void in
				if previousView == self {
					// the first label
					make.leading.equalTo(self).offset(margin)
					make.top.equalTo(self).offset(lineSpacing)
				}
				
				if isLabelAtFirstOfSomeLine(label) {
					make.top.equalTo(previousView.snp_bottom).offset(lineSpacing)
					make.leading.equalTo(self).offset(margin)
				} else {
					if let _ = previousView as? UILabel {
						// every not first label in line
						make.leading.equalTo(previousView.snp_trailing).offset(margin)
						make.baseline.equalTo(previousView)
					}
				}
				
				if label == labels.last {
					// the last label
					make.bottom.equalTo(self).offset(-lineSpacing)
				}
				
//				make.trailing.lessThanOrEqualTo(self).offset(-margin).priorityHigh()
			})
			
			previousView = label
		}
		
		super.updateConstraints()
	}
	
	func isLabelAtFirstOfSomeLine(label: UILabel) -> Bool {
		let index = label.tag
		let result = indexOfFirstLabelInOneLine.contains(index)
		return result
	}
}
