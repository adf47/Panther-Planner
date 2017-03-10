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
    
    struct Constants{
        static var title = ""
    }
    struct type {
        static var type = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("View Loading")
        
        myTextField.text = ""
        
        type.type = ""
        
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
            view.endEditing(true)
        }
        else{
            //do search here 
            Constants.title = myTextField.text!
            type.type = "search"
        }
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard(myTextField: UITextField) -> Bool {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        print("TAPPED!!")
        //self.myTextField.resignFirstResponder()
        view.endEditing(true)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //search method here 
        
        print("Search tapped")
        Constants.title = myTextField.text!
        type.type = "search"
        view.endEditing(true)
        return false
    }

    @IBAction func majorBtPressed(_ sender: Any) {
        type.type = "major"
    }
    @IBAction func credBtPressed(_ sender: Any) {
        type.type = "credits"
    }
    
}

