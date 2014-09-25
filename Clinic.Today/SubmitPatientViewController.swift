//
//  SubmitPatientViewController.swift
//  Clinic.Today
//
//  Created by Ruben on 8/8/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit

class SubmitPatientViewController: UIViewController {
    var delegate = UIApplication.sharedApplication().delegate as AppDelegate
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var remember: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "patientDidSubmit:",
            name: "PatientFinishedLoading",
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPatient(sender: AnyObject) {
        var cleanedPhone = self.phone.text.extractNumerics()

        if self.firstName.text == "" ||
            self.lastName.text == "" ||
            countElements(cleanedPhone) != 10 ||
            self.email.text    == "" {
                var err = UIAlertView(title: "Invalid Information",
                    message: "Sorry, it looks like you missed a field or entered an invalid phone number. Please try again.",
                    delegate: self,
                    cancelButtonTitle: "OK")
                err.show()
        } else {
            self.delegate.patient!.firstName = self.firstName.text
            self.delegate.patient!.lastName  = self.lastName.text
            self.delegate.patient!.email     = self.email.text
            self.delegate.patient!.phone     = cleanedPhone
            self.delegate.patient!.POST()
        }
    }
    
    @IBAction func whyPrompt(sender: AnyObject) {
        var why = UIAlertView(title: "Why do we need this?",
            message: "This information lets us hold your spot at the clinic. Once you submit, you will receive more instructions via text message. (Standard messaging rates apply)",
            delegate: self,
            cancelButtonTitle: "OK")
        why.show()
    }
    
    func patientDidSubmit(notification : NSNotification) {
        self.navigationController!.popToRootViewControllerAnimated(true)
        var success = UIAlertView(title: "Success",
            message: "You are now in line at \(self.delegate.clinic!.name)! Your expected wait time is \(self.delegate.patient!.waitTime).",
            delegate: self,
            cancelButtonTitle: "OK")
        success.show()
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

extension Array {
    func combine(separator: String) -> String{
        var str : String = ""
        for (idx, item) in enumerate(self) {
            str += "\(item)"
            if idx < self.count-1 {
                str += separator
            }
        }
        return str
    }
}

extension String {
    func extractNumerics() -> String {
        var numerics = NSCharacterSet(charactersInString: "0123456789").invertedSet
        return self.componentsSeparatedByCharactersInSet(numerics).combine("")
    }
}
