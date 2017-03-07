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

class SeeCreditsView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables for cloudkit
    //var database = CKContainer.default().publicCloudDatabase
    
    var Record = CKRecord(recordType: "Course")
    var category = ""
    
    
    var sweets = [CKRecord]()
    var refresh:UIRefreshControl!
    
    //things for tale view
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["AFRCNA","ANTH","ARABIC","ASL","ARCH","ARTSC","ASTRON","BIOETH","BIOSC","CHEM","CHLIT","CHIN","CLASS","COMMRC","CS","CLST","EAS","ECON","ENGCMP","ENGFLM","ENGLIT","ENGWRT","ENV","FILMST","FP","FR","FTDA","FTDB","FTDC","GEOL","GREEK","GREEKM","GSWS","HINDI","HIST","HPS","HAA","ISSP","IRISH","ITAL","JPNSE","JS","KOREAN","LATIN","LCTL","LING","MATH","MRST","MUSIC","NROSCI","PERS","PHIL","PEDC","PHYS","POLISH","PS","PORT","PSY","QUECH","REL","RELGST","SERCRO","SLAV","SLOVAK","SOC","SPAN","STAT","SA","SWAHIL","SWE","THEA","TURKSH","UKRAIN","URBNST","VIET"]
    
    var colors = ["9bec7d","cfb563","9ed1a7","cc738d","7bd6e4","701b3a","4964e5","baa867","ffbcb5","649c8a","7eb10b","eb6241","c7a1dd","8c5766","3f6c79","1d385a","e1ba42","6666e0","4fa98d","d8285a","9e1662","9d477b","d4bb82","61d5de","a0af97","97b6d0","38928f","5c4ea3","1f74df","f4b215","3ec6a2","bd6b39","c0190a","94acf5","ec536b","674486","df6f3c","c4d3a9","6566a5","df6f3c","dabbaa","2e5652","2c60aa","90cce5","58929c","6479a3","3a248e","f48c55","c37fde","4095f5","061c2a","72cecf","b9e8e0","e49f59","c0a2ae","7ea3a6","0d79fd","72b50d","9ad56a","d14e42","7d60f8","440e4b","0caf7c","c0ce52","e05dba","80a5ee","33599c","fe9082","826864","234a78","5fa451","99e18b","e2346a","568e96","6c338c","01405b","fca241"]
    
    
    // Data model: These strings will be the data for the table view cells
    var CategoryArray = [String]()
    var tempTitle = ""
    var tempDesc = ""
    var arrayName: Array<String> = []
    var TitleArray = [String]()
    var majorArray = [String]()
    var creditsArray = [String]()
    var timesArray = [String]()
    var profArray = [String]()
    
    
    var buttons = [ClassCollectionViewCell]()
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let reuseIdentifier = "cell2"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        DispatchQueue.main.async {
            self.loadData()
        }
        
       /* refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to Refresh Page")
        refresh.addTarget(self, action: #selector(SeeCreditsView.loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 1000.0
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self*/
        
        
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
                    //print(result["classTitle"] as? String)
                    //print(result["credits"] as? String)
                    //print(credits.Constants.credits)
                    if(tempCat == credits.Constants.credits){
                        let tempTitle = result["classTitle"] as? String
                        let major = result["major"] as? String
                        let credits = result["credits"] as? String
                        let time = result["DayTimeClassRoomBuilding"] as? String
                        let teacher = result["prof"] as? String
                        
                        print("Should be working")
                        //self.CategoryArray.append(tempDes!)
                        self.TitleArray.append(tempTitle!)
                        self.majorArray.append(major!)
                        self.creditsArray.append(credits!)
                        self.timesArray.append(time!)
                        self.profArray.append(teacher!)
                        
                    }
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                }
            }
        }
        
    }
    
    
    
    // number of rows in table view
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
    }*/
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("HI") //just for testing
        return self.creditsArray.count
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ClassCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.courseNum.text = self.majorArray[indexPath.row]
        cell.courseNum.layer.masksToBounds = true
        cell.courseNum.layer.cornerRadius = 8.0
        
        //change color of box on the left here 
        let colorIndex = items.index(of: self.majorArray[indexPath.row])
        if(colorIndex != nil){
            cell.courseNum.backgroundColor = hexStringToUIColor(hex: self.colors[colorIndex!])
        }
        
        cell.className.text = self.TitleArray[indexPath.row]
        cell.credits.text = "Credits: \(self.creditsArray[indexPath.row])"
        cell.times.text = "times: \(self.timesArray[indexPath.row])"
        cell.professor.text = self.profArray[indexPath.row]
        
        cell.backgroundColor = UIColor.white // make cell more visible in our example project
        
        self.buttons.append(cell)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected \(16 - indexPath.item)!")
        print("\(buttons[indexPath.item].className)")
        //Constants.credits = "\(16 - indexPath.item) cr."
        //buttons[indexPath.item].backgroundColor = UIColor.brown
        
    }
    
    
    //coverts hex colors to UIColors that are useable
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}

