//
//  ViewController.swift
//  iCourse Database Uploader
//
//  Created by Antonino Febbraro on 2/11/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import Cocoa
import CloudKit

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
    
    var database = CKContainer.default().publicCloudDatabase
    //var Record = CKRecord(recordType: "Course")

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
        
        
        let myStringArr = file.components(separatedBy: "\n")
        
        while(x<myStringArr.count){
            
            var Record = CKRecord(recordType: "Course")
            print("\n Uploading to database...")
            
            //print(myStringArr[8])
            
            //if(x >= myStringArr.count - 12){
              //  break
            //}
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
            
            Record.setObject(classTitle as CKRecordValue?, forKey: "classTitle")
            Record.setObject(classNum as CKRecordValue?, forKey: "classNum")
            Record.setObject(term as CKRecordValue?, forKey: "term")
            Record.setObject(major as CKRecordValue?, forKey: "major")
            Record.setObject(courseNum as CKRecordValue?, forKey: "courseNum")
            Record.setObject(credits as CKRecordValue?, forKey: "credits")
            Record.setObject(satGenEdReq as CKRecordValue?, forKey: "satGenEdReq")
            Record.setObject(DayTimeClassRoomBuilding as CKRecordValue?, forKey: "DayTimeClassRoomBuilding")
            Record.setObject(prof as CKRecordValue?, forKey: "prof")
            Record.setObject(descrip as CKRecordValue?, forKey: "descrip")
            Record.setObject(prerequistes as CKRecordValue?, forKey: "prerequisites")
            
            self.database.save(Record, completionHandler:
                ({returnRecord, error in
                    if let err = error {
                        print("Save Error" +
                            err.localizedDescription)
                    } else {
                        
                        print("Successful add of \(self.classTitle)")
                        
                        
                    }
                }))
            
            x = x + 14
            print(x)
            //sleep to stall thread for uploading to database
            sleep(5)
        }
    }
    
    
}

