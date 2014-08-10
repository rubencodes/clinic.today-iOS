//
//  HomeViewController.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    var delegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func begin(sender: UIButton) {
        delegate.patient = Patient()
    }
    
}

