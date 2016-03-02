//
//  ResizeView.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit
import SnapKit

protocol ResizeViewDelegate {
	func resizeView(resizeView: ResizeView, didClickAtIndex index: Int)
}

class ResizeView: UIView {
    var segmentedControl: UISegmentedControl!
	var views = [UIView]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
    }
}
