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
    
}
