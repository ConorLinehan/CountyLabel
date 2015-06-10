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
    @IBOutlet var secondLabel: CountyLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        var recognizer = UITapGestureRecognizer(target: self, action: Selector("animate"))
        
        self.view.addGestureRecognizer(recognizer)
        
        
        
    }
    
    func animate(){
        countyLabel.CL_animateWithDuration(0.5, from: 0, to: 10, completion: { _ in
            
            self.secondLabel.CL_animateWithDuration(1, from: 0, to: 1000, completion: nil)
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

