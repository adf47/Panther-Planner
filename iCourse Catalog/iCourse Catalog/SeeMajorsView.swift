//
//  SeeMajorsView.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 2/23/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import Foundation
import UIKit
import CloudKit
import MapKit

class SeeMajorsView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct Classes{
        static var descrip = ""
        static var credits = ""
        static var preq = ""
        static var subjNum = ""
        static var name = ""
        static var color = ""
    }
    
    //Variables for cloudkit
    //var database = CKContainer.default().publicCloudDatabase
    
    var Record = CKRecord(recordType: "Course")
    var category = ""
    
    
    var sweets = [CKRecord]()
    var refresh:UIRefreshControl!
    
    //things for tale view
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var names =
        ["Administration of Justice","Africana Studies","Aerospace Studies","Anthropology","Arabic","Architectural Studies","Dietrich School of Arts and Sciences","American Sign Language","Astronomy",
         "Courses - Off Campus - Butler","Bioengineering","Bioethics","Biological Sciences","Business Accounting","Business Information Systems","Business Economics","Business Environment","Business Service",
         "Business Finance","Business Human Resources Mgt.","Bus. Management Info. Systems","Business Marketing","Bus. Organizational Behavior","Bus. Quant. Methods/Operations Mgt.","Bus. Supply Chain Management",
         "Bus. Strategic Planning and Policy","Career Development - Accounting","Civil & Environmental Engineering","College of General Studies","Courses On Campus Oakland - Day  Evening Program","Courses - On Campus Oakland - Saturday College",
         "Chemical Engineering","Chemistry","Chinese","Children's Lit Program","Classics","Cultural Studies","Computer Engineering","Computer Engineering - Engr","Communication","Computer Science","East Asian Studies","Electrical & Computer Engineering",
         "Economics","Electrical Engineering","English Composition","English Film","English Literature","Engineering","Engineering Physics","English Writing","Energy Resources","Environmental Studies","Film Studies","Freshman Programs","French",
         "Full-Time Dissertation -- Humanities","Full-Time Dissertation -- Natural Sci","Full-Time Dissertation -- Social Sci","FT Diss Study","Geology","German","Greek","Greek, Modern","Gender, Sexuality, and Women's Studies","History of Art and Architecture",
         "Hindi","History","History and Philosophy of Science","Courses -  Online Hybrid","Industrial Engineering","Information Science","Irish","Intelligent Systems","Italian","Japanese","Jewish Studies","Korean","Latin","Less Commonly Taught Languages","Leadership",
         "Legal Studies","Linguistics","Mathematics","Mechanical Engineering","Mechanical Engineering & Materials Science","Military Science & Tact-Army","Medieval and Renaissance St.","Materials Science and Engr","Manufacturing Sys Engineering","Music",
         "National Preparedness & Homeland Security","Neuroscience","Physical Education","Persian","Petroleum Engineering","Philosophy","Physics","Polish","Portuguese","Political Science","Psychology","Public Service","Public Works & Engr Admin","Quechua",
         "Religion, Cooperative Program","Religious Studies","Russian","Studio Arts","Courses -  Online - Self-Paced","Serbian-Croatian","Slavic","Slovak","Sociology","Spanish","Statistics","Swahili","Swedish","Theatre Arts","Turkish","University Honors College","Ukrainian","Urban Studies","Vietnamese","Courses -  Online Web"]
    
    
    var items = ["ADMJ","AFRCNA","AFROTC","ANTH","ARABIC","ARCH","ARTSC","ASL","ASTRON","BCCC","BIOENG","BIOETH","BIOSC","BUSACC","BUSBIS","BUSECN","BUSENV","BUSERV","BUSFIN","BUSHRM","BUSMIS","BUSMKT","BUSORG","BUSQOM","BUSSCM","BUSSPP","CDACCT",
                 "CEE","CGS","CGSDAY","CGSSAT","CHE","CHEM","CHIN","CHLIT","CLASS","CLST","COE","COEE","COMMRC","CS","EAS","ECE","ECON","EE","ENGCMP","ENGFLM","ENGLIT","ENGR","ENGRPH","ENGWRT","ENRES","ENV","FILMST","FP","FR","FTDA","FTDB","FTDC","FTDH",
                 "GEOL","GER","GREEK","GREEKM","GSWS","HAA","HINDI","HIST","HPS","HYBRID","IE","INFSCI","IRISH","ISSP","ITAL","JPNSE","JS","KOREAN","LATIN","LCTL","LDRSHP","LEGLST","LING","MATH","ME","MEMS","MILS","MRST","MSE","MSEP","MUSIC","NPHS","NROSCI","PEDC",
                 "PERS","PETE","PHIL","PHYS","POLISH","PORT","PS","PSY","PUBSRV","PWEA","QUECH","REL","RELGST","RUSS","SA","SELF","SERCRO","SLAV","SLOVAK","SOC","SPAN","STAT","SWAHIL","SWE","THEA","TURKSH","UHC","UKRAIN","URBNST","VIET","WWW"]
    
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
    var descArray = [String]()
    var classNumArray = [String]()
    var preqArray = [String]()
    
    
    var buttons = [ClassCollectionViewCell]()
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let reuseIdentifier = "cell3"
    //majorLabel.text = majors.Constants.major
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(majors.Constants.major)
        
        
        
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
         
         // This view controller itself will provide the delegate methods and row data for the table view.*/
         self.collectionView.delegate = self
         self.collectionView.dataSource = self
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
        
    }
    
    
    
    //method for getting all the data
    func loadData() {
        print("Inside load data now")
        let container = CKContainer(identifier: "iCloud.com.antoninofebbraro.iCourse-Database-Uploader")
        let privateDatabase = container.publicCloudDatabase
        //let predicate = NSPredicate(value: true)
        majorLabel.text = majors.Constants.major
        
        //change label of major here
        var index = items.index(of: majors.Constants.major)
        majorLabel.text = names[index!]
        
        
        let predicate = NSPredicate(format: "major = %@", majors.Constants.major)
        
        
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
                    print(majors.Constants.major)
                    print("error trying agaon")
                } //to make sure data loads in time
                for result in results! {
                    
                    print("in loop ")
                    let tempMajor = result["major"] as? String
                    //print(result["classTitle"] as? String)
                    //print(result["credits"] as? String)
                    //print(majors.Constants.major)
                    if(tempMajor == majors.Constants.major){
                        let tempTitle = result["classTitle"] as? String
                        let major = result["major"] as? String
                        let credits = result["credits"] as? String
                        let time = result["DayTimeClassRoomBuilding"] as? String
                        let teacher = result["prof"] as? String
                        let des = result["descrip"] as? String
                        let num = result["courseNum"] as? String
                        let pre = result["prerequisites"] as? String
                        
                        print("Should be working")
                        //self.CategoryArray.append(tempDes!)
                        self.TitleArray.append(tempTitle!)
                        self.majorArray.append(major!)
                        self.creditsArray.append(credits!)
                        self.timesArray.append(time!)
                        self.profArray.append(teacher!)
                        self.descArray.append(des!)
                        self.classNumArray.append(num!)
                        self.preqArray.append(pre!)
                        
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
        
        print("HI") //just for testing
        return self.TitleArray.count
        
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
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10.0
        
        self.buttons.append(cell)
        //print("returning cell!!")
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //print("You selected \(16 - indexPath.item)!")
        //print("\(buttons[indexPath.item].className)")
        //Constants.credits = "\(16 - indexPath.item) cr."
        //buttons[indexPath.item].backgroundColor = UIColor.brown
        
        //update class struct here
        Classes.name = self.TitleArray[indexPath.item]
        Classes.credits = self.creditsArray[indexPath.item]
        Classes.descrip = self.descArray[indexPath.item]
        Classes.subjNum = "\(self.majorArray[indexPath.item]) \(self.classNumArray[indexPath.item])"
        Classes.preq = self.preqArray[indexPath.item]
        var colorIndex = items.index(of: self.majorArray[indexPath.item])
        if(colorIndex != nil){
            Classes.color = self.colors[colorIndex!]
        }
        
        //update class struct here
        Classes.name = self.TitleArray[indexPath.item]
        Classes.credits = self.creditsArray[indexPath.item]
        Classes.descrip = self.descArray[indexPath.item]
        Classes.subjNum = "\(self.majorArray[indexPath.item]) \(self.classNumArray[indexPath.item])"
        Classes.preq = self.preqArray[indexPath.item]
        colorIndex = items.index(of: self.majorArray[indexPath.item])
        if(colorIndex != nil){
            Classes.color = self.colors[colorIndex!]
        }
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
