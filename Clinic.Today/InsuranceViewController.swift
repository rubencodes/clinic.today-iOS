//
//  InsuranceViewController.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class InsuranceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var delegate = UIApplication.sharedApplication().delegate as AppDelegate
    @IBOutlet weak var insurancePlans: UIPickerView!
    var insurances : [Insurance]?
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "insurancesDidLoad:",
            name: "InsurancesFinishedLoading",
            object: nil)
        
        self.insurances = []
        
        Insurance.GET()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insurancesDidLoad(notification : NSNotification) {
        var userInfo = notification.userInfo as Dictionary<String, [Insurance]>
        self.insurances = userInfo["Insurances"]
        
        self.insurancePlans.reloadAllComponents()
        self.navigationController!.navigationBar.topItem!.rightBarButtonItem!.enabled = true
        loading.stopAnimating()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView! {
        var label = view as? UILabel
        
        if label == nil {
            label = UILabel()
            label!.font = UIFont(name: "OpenSans-Light", size: 14)
        }
        
        label!.text = self.insurances![row].name
        return label
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.insurances!.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.insurances![row].name
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "nearbyClinics" {
            delegate.patient!.insurance_plan = insurances![self.insurancePlans.selectedRowInComponent(0)].name
        }
    }
}
