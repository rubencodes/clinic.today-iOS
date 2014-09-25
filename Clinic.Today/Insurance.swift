//
//  Insurance.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class Insurance: NSObject {
    var name : String
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    class func GET() {
        var urlString = "http://localhost:3000/api/v1/insurances"
        var url = NSURL(string: urlString)
        var urlRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            if error == nil {
                Insurance.parseData(data)
            } else {
                NSLog("\(error.localizedDescription)")
                var alert = UIAlertView(title: "Network Error",
                    message: "Sorry, we're having some trouble reaching our server at the moment. Please try again later!",
                    delegate: self,
                    cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    
    class func parseData(data : NSData) {
        var parsedObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.convertFromNilLiteral(), error: nil) as NSDictionary
        var results = parsedObject.valueForKey("insurances") as [NSDictionary]
        var insurances : [Insurance] = []
        for insuranceDict in results {
            var name = insuranceDict["name"] as String
            var insurance = Insurance(name: name)
            
            insurances.append(insurance)
        }
        
        var userInfo = NSDictionary(object: insurances, forKey: "Insurances")
        NSNotificationCenter.defaultCenter().postNotificationName("InsurancesFinishedLoading",
            object: nil,
            userInfo: userInfo)
    }
}
