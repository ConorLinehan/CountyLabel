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
        
        countyLabel.text = "10"
        secondLabel.text = "Apple"
        
        countyLabel.CL_animateWithDuration(0.5, to: 20, completion: { _ in
            
            self.secondLabel.CL_animateWithDuration(1,to: 50, completion: nil)
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

