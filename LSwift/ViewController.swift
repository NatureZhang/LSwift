//
//  ViewController.swift
//  LSwift
//
//  Created by zhangdong on 2017/1/11.
//  Copyright © 2017年 __Nature__. All rights reserved.
//

//=====================================================
//  人要学会，放下无用的恐惧，将全部精力，投入到事情本身
//=====================================================

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label: UILabel = UILabel();
        label.frame = CGRect.init(origin: CGPoint.init(x: 50, y: 50), size: CGSize.init(width: 100, height: 100))
        label.backgroundColor = UIColor.red;
        self.view.addSubview(label);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

