//
//  ViewController.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 2/22/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTextField.delegate = self as? UITextFieldDelegate
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //self.view.endEditing(true)
        textField.resignFirstResponder()
        return false
    
        
    }
    @IBAction func textViewExit(_ sender: Any) {
        myTextField.resignFirstResponder()
        //return false
    }

}

