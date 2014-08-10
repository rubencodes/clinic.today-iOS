//
//  Clinic.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class Clinic: NSObject {
    var name    : String
    var address : String
    var phone   : String
    var about   : String
    var hours   : String
    var queue   : String
    var distance : Int
    var waitTime : String
    var lineSize : String
    
    init(name: String, address: String, phone: String, about: String, hours: String, distance: Int, waitTime: String, lineSize: String, queue: String) {
        self.name = name
        self.address = address
        self.phone  = phone
        self.about  = about
        self.hours  = hours
        self.queue  = queue
        self.distance = distance
        self.waitTime = waitTime
        self.lineSize = lineSize
        
        super.init()
    }
    
    class func GET(lat : Double, lon : Double, insurance : String) {
        var ins = ""
        if insurance != "I'll pay with cash" {
            ins = insurance.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        }
        
        var urlString = "http://localhost:3000/api/v1/clinics?lat=\(lat)&lon=\(lon)&dist=25000&ins=\(ins)"
        var url = NSURL(string: urlString)
        var urlRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            if error == nil {
                Clinic.parseData(data)
            } else {
                NSLog("\(error.localizedDescription)")
            }
        })
    }
    
    class func parseData(data : NSData) {
        var parsedObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.convertFromNilLiteral(), error: nil) as NSDictionary
        var results = parsedObject.valueForKey("clinics") as [NSDictionary]
        var clinics : [Clinic] = []
        for clinicDict in results {
            var name = clinicDict["name"]     as String
            var street = clinicDict["street"] as String
            var city   = clinicDict["city"]   as String
            var state  = clinicDict["state"]  as String
            var zip    = clinicDict["zip"]    as Int
            var address = "\(street), \(city), \(state), \(zip)"
            var phone   = clinicDict["phone"]  as String
            var about   = clinicDict["description"] as String
            var hours   = clinicDict["hours"]    as String
            var queue   = clinicDict["queue_id"] as String
            var distance = clinicDict["distance"]    as Int
            var waitTime = clinicDict["wait_time"]   as String
            var lineSize = clinicDict["line_size"]   as String
            var clinic = Clinic(name: name, address: address, phone: phone, about: about, hours: hours, distance: distance, waitTime: waitTime, lineSize: lineSize, queue: queue)
            
            clinics.append(clinic)
        }
        
        var userInfo = NSDictionary(object: clinics, forKey: "Clinics")
        NSNotificationCenter.defaultCenter().postNotificationName("ClinicsFinishedLoading",
            object: nil,
            userInfo: userInfo)
    }
}
