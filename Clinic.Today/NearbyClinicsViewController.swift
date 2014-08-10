//
//  NearbyClinicsViewController.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class NearbyClinicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var delegate = UIApplication.sharedApplication().delegate as AppDelegate
    var clinics : [Clinic]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "clinicsDidLoad:",
            name: "ClinicsFinishedLoading",
            object: nil)
        
        self.clinics = []
        
        Clinic.GET(self.delegate.coordinate!.latitude,
            lon: self.delegate.coordinate!.longitude,
            insurance: self.delegate.patient!.insurance_plan)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clinicsDidLoad(notification : NSNotification) {
        
        var userInfo = notification.userInfo as NSDictionary
        self.clinics = userInfo.objectForKey("Clinics") as? [Clinic]
        
        self.tableView.reloadData()
        self.tableView.sizeToFit()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        loading.stopAnimating()
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let simpleTableIdentifier: NSString = "SimpleTableCell"
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: simpleTableIdentifier)
        }
        
        cell.textLabel.text = self.clinics![indexPath.row].name
        cell.detailTextLabel.text = "\(self.clinics![indexPath.row].distance) mi"
        
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return clinics!.count
    }
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) -> [AnyObject]! {
        var action = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
            title: "Get in Line",
            handler: {
                void in
                //update styling of cell
                self.delegate.clinic = self.clinics![indexPath.row]
                self.performSegueWithIdentifier("getInLine", sender: self)
        })
        action.backgroundColor = self.delegate.primaryColor
        
        return [action]
    }
    
    //UITableView delegate method, needed because of bug in iOS 8 for now
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // No statement or algorithm is needed in here. Just the implementation
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectedClinic" {
            var controller = segue.destinationViewController as ClinicViewController
            self.delegate.clinic = self.clinics![tableView.indexPathForCell((sender as UITableViewCell)).row]
        }
    }

}
