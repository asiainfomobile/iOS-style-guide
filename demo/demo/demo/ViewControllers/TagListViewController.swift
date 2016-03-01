//
//  TagListViewController.swift
//  demo
//
//  Created by admin on 3/1/16.
//  Copyright © 2016 __ASIAINFO__. All rights reserved.
//

import UIKit

class TagListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tagListView = TagListView(tags: ["very long text","short","abcdefghijklmn"])
        view.addSubview(tagListView)
        
        tagListView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
