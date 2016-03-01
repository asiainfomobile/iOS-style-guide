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
	var spaceOfLines: CGFloat = 10
	
	init(tags: [String]) {
		super.init(frame: .zero)
		self.tags = tags
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
					super.layoutSubviews()
				}
				break
			}
		}
	}
	
	override func updateConstraints() {
		var previousView: UIView! = self
		for label in labels {
			label.snp_makeConstraints(closure: { (make) -> Void in
				if previousView == self {
					// the first label
					make.leading.equalTo(self).offset(margin)
					make.top.equalTo(self).offset(spaceOfLines)
				}
				
				if isLabelAtFirstOfSomeLine(label) {
					make.top.equalTo(previousView).offset(spaceOfLines)
					make.leading.equalTo(self).offset(margin)
				}
				
				if label == labels.last {
					make.bottom.equalTo(self).offset(-spaceOfLines)
				}
				
				make.trailing.lessThanOrEqualTo(self).offset(-margin).priorityHigh()
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
    
    override func intrinsicContentSize() -> CGSize {
        
    }
}
