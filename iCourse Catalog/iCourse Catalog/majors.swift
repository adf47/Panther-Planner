//
//  majors.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 2/23/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class majors:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct Constants{
        static var major = ""
    }
    
    let reuseIdentifier = "cell"
    var items = [String]()
    var colors = [String]()
    var names = [String]()
    var buttons = [MyCollectionViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        names =
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
        
        
        items = ["ADMJ","AFRCNA","AFROTC","ANTH","ARABIC","ARCH","ARTSC","ASL","ASTRON","BCCC","BIOENG","BIOETH","BIOSC","BUSACC","BUSBIS","BUSECN","BUSENV","BUSERV","BUSFIN","BUSHRM","BUSMIS","BUSMKT","BUSORG","BUSQOM","BUSSCM","BUSSPP","CDACCT",
                     "CEE","CGS","CGSDAY","CGSSAT","CHE","CHEM","CHIN","CHLIT","CLASS","CLST","COE","COEE","COMMRC","CS","EAS","ECE","ECON","EE","ENGCMP","ENGFLM","ENGLIT","ENGR","ENGRPH","ENGWRT","ENRES","ENV","FILMST","FP","FR","FTDA","FTDB","FTDC","FTDH",
                     "GEOL","GER","GREEK","GREEKM","GSWS","HAA","HINDI","HIST","HPS","HYBRID","IE","INFSCI","IRISH","ISSP","ITAL","JPNSE","JS","KOREAN","LATIN","LCTL","LDRSHP","LEGLST","LING","MATH","ME","MEMS","MILS","MRST","MSE","MSEP","MUSIC","NPHS","NROSCI","PEDC",
                     "PERS","PETE","PHIL","PHYS","POLISH","PORT","PS","PSY","PUBSRV","PWEA","QUECH","REL","RELGST","RUSS","SA","SELF","SERCRO","SLAV","SLOVAK","SOC","SPAN","STAT","SWAHIL","SWE","THEA","TURKSH","UHC","UKRAIN","URBNST","VIET","WWW"]
        
        colors = ["9bec7d","cfb563","9ed1a7","cc738d","7bd6e4","701b3a","4964e5","baa867","ffbcb5","649c8a","7eb10b","eb6241","c7a1dd","8c5766","3f6c79","1d385a","e1ba42","6666e0","4fa98d","d8285a","9e1662","9d477b","d4bb82","61d5de","a0af97","97b6d0","38928f","5c4ea3","1f74df","f4b215","3ec6a2","bd6b39","c0190a","94acf5","ec536b","674486","df6f3c","c4d3a9","6566a5","df6f3c","dabbaa","2e5652","2c60aa","90cce5","58929c","6479a3","3a248e","f48c55","c37fde","4095f5","061c2a","72cecf","b9e8e0","e49f59","c0a2ae","7ea3a6","0d79fd","72b50d","9ad56a","d14e42","7d60f8","440e4b","0caf7c","c0ce52","e05dba","80a5ee","33599c","fe9082","826864","234a78","5fa451","99e18b","e2346a","568e96","6c338c","01405b","fca241"]
        
    }
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("HI")
        return self.items.count
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.myLabel.text = self.items[indexPath.item]
        let color1 = hexStringToUIColor(hex: self.colors[indexPath.item])
        cell.myLabel.backgroundColor = color1 // make cell more visible in our example project
        cell.myLabel.layer.masksToBounds = true
        cell.myLabel.layer.cornerRadius = 8.0
        
        self.buttons.append(cell)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected \(16 - indexPath.item)!")
        Constants.major = items[indexPath.item]
        buttons[indexPath.item].backgroundColor = UIColor.brown
        
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
