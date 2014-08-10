//
//  ClinicViewController.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class ClinicViewController: UIViewController {
    var delegate = UIApplication.sharedApplication().delegate as AppDelegate
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var lineSize: UILabel!
    @IBOutlet weak var waitTime: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var hours: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.delegate.clinic != nil {
            self.name.text = self.delegate.clinic!.name
            self.about.text = self.delegate.clinic!.about
            self.hours.text = self.delegate.clinic!.hours
            self.distance.text = "\(self.delegate.clinic!.distance) mi"
            self.lineSize.text = "\(self.delegate.clinic!.lineSize) in line"
            self.waitTime.text = self.delegate.clinic!.waitTime
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func viewMap(sender: AnyObject) {
        NSLog("\(self.delegate.clinic!.address)")
        var url = NSURL(string: "http://maps.apple.com/?q=\(self.delegate.clinic!.address.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))")
        UIApplication.sharedApplication().openURL(url);
    }
    
    @IBAction func callNow(sender: AnyObject) {
        var url = NSURL(string: "tel://\(self.delegate.clinic!.phone)")
        UIApplication.sharedApplication().openURL(url);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
