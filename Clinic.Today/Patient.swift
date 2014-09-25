//
//  Patient.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class Patient: NSObject {
    var firstName:      String = ""
    var lastName:       String = ""
    var insurance_plan: String = ""
    var email:          String = ""
    var phone:          String = ""
    var waitTime:       String = ""
    var queue:          String = ""
    
    func POST() {
        var patientInfo = NSDictionary(objects: [self.firstName, self.lastName, self.insurance_plan, self.email, self.phone, self.queue], forKeys: ["first_name", "last_name", "insurance_plan", "email", "phone", "queue"])
        var patientWrapper = NSDictionary(object: patientInfo, forKey: "patient")
        
        var urlString = "http://localhost:3000/api/v1/patients"
        var url = NSURL(string: urlString)
        var POST = NSMutableURLRequest(URL: url)
        POST.HTTPMethod = "POST"
        POST.setValue("application/json", forHTTPHeaderField: "Accept")
        POST.setValue("application/json", forHTTPHeaderField: "Content-Type")
        POST.HTTPBody = NSJSONSerialization.dataWithJSONObject(patientWrapper, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        NSURLConnection.sendAsynchronousRequest(POST, queue: NSOperationQueue.mainQueue(), completionHandler: {
            (response : NSURLResponse?, data : NSData?, error : NSError?) in
            if error == nil {
                if (response! as NSHTTPURLResponse).statusCode != 500 {
                    self.parseData(data!)
                } else {
                    var alert = UIAlertView(title: "Server Error",
                        message: "It's not you, it's us. Please try again later!",
                        delegate: self,
                        cancelButtonTitle: "OK")
                    alert.show()
                }
            } else {
                NSLog(error!.localizedDescription)
                var alert = UIAlertView(title: "Network Error",
                    message: "Sorry, we're having some trouble reaching our server at the moment. Please try again later!",
                    delegate: self,
                    cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    
    func parseData(data : NSData) {
        var parsedObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.convertFromNilLiteral(), error: nil) as NSDictionary
        var result = parsedObject.valueForKey("patient") as [NSDictionary]
        var patient : Patient
        for patientDict in result {
            self.waitTime = patientDict["wait_time"] as String
        }
        
        var userInfo = NSDictionary(object: self, forKey: "Patient")
        NSNotificationCenter.defaultCenter().postNotificationName("PatientFinishedLoading",
            object: nil,
            userInfo: userInfo)
    }
}
