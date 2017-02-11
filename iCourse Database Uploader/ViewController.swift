//
//  ViewController.swift
//  iCourse Database Uploader
//
//  Created by Antonino Febbraro on 2/11/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var file = ""
    var x = 0
    
    var classNum = ""
    var term = ""
    var major = ""
    var courseNum = ""
    var classTitle = ""
    var credits = ""
    var satGenEdReq = ""
    var DayTimeClassRoomBuilding = ""
    var prof = ""
    var descrip = ""
    var prerequistes = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    
    @IBAction func UpdateDatabase(_ sender: Any) {
        
        if let fileURL = Bundle.main.url(forResource:"Courses", withExtension: ".txt")
        {
            do {
                let contents = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
                //print(contents)
                file = contents
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("No such file URL.")
        }
        
        UploadFile()
        
    }
    
    func UploadFile(){
        
        print("\n Uploading to database...")
        let myStringArr = file.components(separatedBy: "\n")
        
        while(x<myStringArr.count){
            
            //print(myStringArr[8])
            
            if(x == myStringArr.count - 1){
                break
            }
            classNum = myStringArr[x]
            term = myStringArr[x+1]
            major = myStringArr[x+2]
            courseNum = myStringArr[x+3]
            classTitle = myStringArr[x+4]
            credits = myStringArr[x+5]
            satGenEdReq = myStringArr[x+6]
            DayTimeClassRoomBuilding = myStringArr[x+7]
            prof = myStringArr[x+8]
            descrip = myStringArr[x+10]
            prerequistes = myStringArr[x+12]
            
            x = x + 14
            //print(classNum)
        }
    }
    
    
}

