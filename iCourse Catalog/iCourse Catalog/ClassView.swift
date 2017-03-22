//
//  ClassView.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 3/7/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import Foundation
import UIKit
import CloudKit
import MapKit

class ClassView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    //Variables for cloudkit
    //var database = CKContainer.default().publicCloudDatabase
    
    var Record = CKRecord(recordType: "Course")
    var category = ""
    
    
    var sweets = [CKRecord]()
    var refresh:UIRefreshControl!
    
    //things for tale view
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["AFRCNA","ANTH","ARABIC","ASL","ARCH","ARTSC","ASTRON","BIOETH","BIOSC","CHEM","CHLIT","CHIN","CLASS","COMMRC","CS","CLST","EAS","ECON","ENGCMP","ENGFLM","ENGLIT","ENGWRT","ENV","FILMST","FP","FR","FTDA","FTDB","FTDC","GEOL","GREEK","GREEKM","GSWS","HINDI","HIST","HPS","HAA","ISSP","IRISH","ITAL","JPNSE","JS","KOREAN","LATIN","LCTL","LING","MATH","MRST","MUSIC","NROSCI","PERS","PHIL","PEDC","PHYS","POLISH","PS","PORT","PSY","QUECH","REL","RELGST","SERCRO","SLAV","SLOVAK","SOC","SPAN","STAT","SA","SWAHIL","SWE","THEA","TURKSH","UKRAIN","URBNST","VIET"]
    
    var colors = ["9bec7d","cfb563","9ed1a7","cc738d","7bd6e4","701b3a","4964e5","baa867","ffbcb5","649c8a","7eb10b","eb6241","c7a1dd","8c5766","3f6c79","1d385a","e1ba42","6666e0","4fa98d","d8285a","9e1662","9d477b","d4bb82","61d5de","a0af97","97b6d0","38928f","5c4ea3","1f74df","f4b215","3ec6a2","bd6b39","c0190a","94acf5","ec536b","674486","df6f3c","c4d3a9","6566a5","df6f3c","dabbaa","2e5652","2c60aa","90cce5","58929c","6479a3","3a248e","f48c55","c37fde","4095f5","061c2a","72cecf","b9e8e0","e49f59","c0a2ae","7ea3a6","0d79fd","72b50d","9ad56a","d14e42","7d60f8","440e4b","0caf7c","c0ce52","e05dba","80a5ee","33599c","fe9082","826864","234a78","5fa451","99e18b","e2346a","568e96","6c338c","01405b","fca241"]
    
    
    
    @IBOutlet weak var SubjectClassNum: UILabel!
    
    @IBOutlet weak var ClassTitle: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    
    @IBOutlet weak var credits: UILabel!
    
    @IBOutlet weak var preq: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Seting up view for class")
        print(ViewController.type.type)
        print(SearchBar.Classes.subjNum)
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ClassView.loadAgain), userInfo: nil, repeats: false)
        //loadAgain()
        

    }
    
    func loadAgain(){
        
        print("in load again")
        //set up label text here
        if(ViewController.type.type == "search"){
            SubjectClassNum.text = SearchBar.Classes.subjNum
            SubjectClassNum.backgroundColor = hexStringToUIColor(hex: SearchBar.Classes.color)
            ClassTitle.text = SearchBar.Classes.name
            Description.text = SearchBar.Classes.descrip
            credits.text = SearchBar.Classes.credits
            preq.text = SearchBar.Classes.preq
        }
        else if(ViewController.type.type == "major"){
            SubjectClassNum.text = SeeMajorsView.Classes.subjNum
            SubjectClassNum.backgroundColor = hexStringToUIColor(hex: SeeMajorsView.Classes.color)
            ClassTitle.text = SeeMajorsView.Classes.name
            Description.text = SeeMajorsView.Classes.descrip
            credits.text = SeeMajorsView.Classes.credits
            preq.text = SeeMajorsView.Classes.preq
            
        }
        else if(ViewController.type.type == "credits"){
            print(SeeCreditsView.Classes.descrip)
            SubjectClassNum.text = SeeCreditsView.Classes.subjNum
            SubjectClassNum.backgroundColor = hexStringToUIColor(hex: SeeCreditsView.Classes.color)
            ClassTitle.text = SeeCreditsView.Classes.name
            Description.text = SeeCreditsView.Classes.descrip
            credits.text = SeeCreditsView.Classes.credits
            preq.text = SeeCreditsView.Classes.preq
        }
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        print("Go Back")
        //_ = navigationController?.popViewController(animated: true)
        //_ = navigationController?.popToRootViewController(animated: true)
        performSegueToReturnBack()
    }
    
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
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
    
    
    //funcion for when rate button is clicked to rate class
    @IBAction func rateClass(_ sender: Any) {
        print("Rate button pressed")
        //display content here
        let alertController2 = UIAlertController(
            title: "Rate Class",
            message:"Give it a star rating!",
            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let action = UIAlertAction(
        title: "Cancel", style: UIAlertActionStyle.default) {
            (action) -> Void in
        }
        
        let upVote1 = UIAlertAction(
        title: "1 Star", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            print("Liked!")
            
        
            
        }
        let upVote2 = UIAlertAction(
        title: "2 Stars", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
           print("Dislike")
            
        }
        let upVote3 = UIAlertAction(
        title: "3 Stars", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            print("Dislike")
            
        }
        let upVote4 = UIAlertAction(
        title: "4 Stars", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            print("Dislike")
            
        }
        let upVote5 = UIAlertAction(
        title: "5 Stars", style: UIAlertActionStyle.default) {
            (action) -> Void in
            
            print("Dislike")
            
        }
        
        
        alertController2.addAction(action)
        alertController2.addAction(upVote1)
        alertController2.addAction(upVote2)
        alertController2.addAction(upVote3)
        alertController2.addAction(upVote4)
        alertController2.addAction(upVote5)
        
        self.present(alertController2, animated: true, completion: nil)
        
    }
}
