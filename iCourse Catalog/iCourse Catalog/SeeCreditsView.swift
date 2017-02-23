//
//  SeeCreditsView.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 2/22/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import Foundation
import UIKit
import CloudKit
import MapKit

class SeeCreditsView: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //Variables for cloudkit
    //var database = CKContainer.default().publicCloudDatabase
    
    var Record = CKRecord(recordType: "Course")
    var category = ""
    
    
    var sweets = [CKRecord]()
    var refresh:UIRefreshControl!
    
    //things for tale view
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // Data model: These strings will be the data for the table view cells
    var CategoryArray = [String]()
    var tempTitle = ""
    var tempDesc = ""
    var arrayName: Array<String> = []
    var TitleArray = [String]()
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        DispatchQueue.main.async {
            self.loadData()
        }
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to Refresh Page")
        refresh.addTarget(self, action: #selector(SeeCreditsView.loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 1000.0
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    
    //method for getting all the data
    func loadData() {
        print("Inside load data now")
        let container = CKContainer(identifier: "iCloud.com.antoninofebbraro.iCourse-Database-Uploader")
        let privateDatabase = container.publicCloudDatabase
        //let predicate = NSPredicate(value: true)
        
        // Create a predicate to retrieve records within a radius of the user's location
        //let radius: CGFloat = 8.05
        // meters
        let predicate = NSPredicate(format: "credits = %@", credits.Constants.credits)
        
        
        let query = CKQuery(recordType: "Course", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print(error!)
                print("Somthing went wrong")
            }
            else {
                print("Working")
                if(results! == Optional([])!){
                   self.loadData()
                    print("error trying agaon")
                } //to make sure data loads in time
                for result in results! {
                    
                    print("in loop ")
                    let tempCat = result["credits"] as? String
                    print(result["classTitle"] as? String)
                    print(result["credits"] as? String)
                    print(credits.Constants.credits)
                    if(tempCat == credits.Constants.credits){
                        let tempTitle = result["classTitle"] as? String
                        
                        print("Should be working")
                        //self.CategoryArray.append(tempDes!)
                        self.TitleArray.append(tempTitle!)
                        
                        
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
            }
        }
        
    }
    
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.TitleArray.count)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        
        cell.textLabel?.text = self.TitleArray[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        /*let container = CKContainer.default()
        let privateDatabase = container.publicCloudDatabase
        
        var rec = [CKRecord]()
        
        // Create a predicate to retrieve records within a radius of the user's location
        let radius: CGFloat = 8.05 // -- ABOUT 5 MILES  --- being generous
        // kilometers
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(Location, %@) < %f", loc, radius)
        
        let query = CKQuery(recordType: "Pins", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { results, error in
            if error == nil { // There is no error
                
                for entry in results! {
                    print("In loop")
                    //code here to update likes or dislikes here
                    var testString = entry["PinTitle"] as? String
                    if(testString == self.TitleArray[indexPath.row]){
                        rec.append(entry)
                        //print(entry)
                    }
                }
            }
        }
        
        //display content here
        let alertController2 = UIAlertController(
            title: self.TitleArray[indexPath.row],
            message: self.CategoryArray[indexPath.row],
            preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(
        title: "Done", style: UIAlertActionStyle.default) {
            (action) -> Void in
        }
        
        let upVote = UIAlertAction(
        title: "Like", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            print("Liked!")
            
            let tempRec = rec.popLast()
            var likeCount = tempRec!["Likes"] as? Int64
            if(likeCount != nil){
                likeCount = likeCount! + 1
            }
            
            //update the database on likes here
            tempRec!.setValue(likeCount, forKey: "Likes")
            privateDatabase.save(tempRec!, completionHandler:
                ({returnRecord, error in
                    if let err = error {
                        print("Save Error" +
                            err.localizedDescription)
                    } else {
                        
                        
                        
                    }
                }))
            
        }
        let downVote = UIAlertAction(
        title: "Dislike", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            print("DisLiked!")
            
            let tempRec = rec.popLast()
            var dislikeCount = tempRec!["DisLikes"] as? Int64
            if(dislikeCount != nil){
                dislikeCount = dislikeCount! + 1
            }
            
            //update the database on dislikes here
            tempRec!.setValue(dislikeCount, forKey: "DisLikes")
            privateDatabase.save(tempRec!, completionHandler:
                ({returnRecord, error in
                    if let err = error {
                        print("Save Error" +
                            err.localizedDescription)
                    } else {
                        
                        
                        
                    }
                }))
            
        }
        
        alertController2.addAction(action)
        alertController2.addAction(upVote)
        alertController2.addAction(downVote)
        
        //alertController2.addAction(action)
        self.present(alertController2, animated: true, completion: nil) */
    }
    
    
    
}

