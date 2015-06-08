//
//  ViewController.swift
//  CountyLabelTestProject
//
//  Created by Conor Linehan on 05/06/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var countyLabel: CountyLabel!
    @IBOutlet var standardLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        countyLabel.CL_animateWithDuration(2, from: 0, to: 100, completion: nil)
        
        [UIView .animateWithDuration(2, animations: {
            self.standardLabel.textColor = UIColor.redColor()
        })]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

