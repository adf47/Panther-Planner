//
//  ViewController.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 2/22/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTextField.delegate = self 
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //function to search for input
    @IBAction func search(_ sender: Any) {
        
        if(myTextField.text == ""){
            print("no text")
        }
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard(myTextField: UITextField) -> Bool {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        print("TAPPED!!")
        //self.myTextField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //search method here 
        
        print("Search tapped")
        view.endEditing(true)
        return false
    }

}

