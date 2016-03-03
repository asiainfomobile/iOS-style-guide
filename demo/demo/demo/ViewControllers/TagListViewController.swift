//
//  TagListViewController.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class TagListViewController: UIViewController {
	
	var tagListView: TagListView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tagListView = TagListView(tags: ["first word", "second word", "third word"])
		view.addSubview(tagListView)
		tagListView.backgroundColor = UIColor.grayColor()
		
		tagListView.snp_makeConstraints { (make) -> Void in
			make.leading.trailing.equalTo(view)
			make.top.equalTo(view).offset(80)
		}
		
		let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTag")
		navigationItem.rightBarButtonItem = barButtonItem
	}
	
	func addTag() {
		
		let randomNumber = random() % 20
		var randomWord = ""
		
		for _ in 0 ... randomNumber {
            randomWord += "a"
		}
		
		tagListView.tags.append(randomWord)
	}
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        // Code here will execute before the rotation begins.
        // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
        
        coordinator.animateAlongsideTransition({ (context) -> Void in
            
            // Place code here to perform animations during the rotation.
            // You can pass nil for this closure if not necessary.
            
            }) { (context) -> Void in
                
                // Code here will execute after the rotation has finished.
                // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
                
                self.tagListView.renderTags()
        }
    }
}
