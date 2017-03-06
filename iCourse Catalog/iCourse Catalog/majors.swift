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
    var buttons = [MyCollectionViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = ["CS","MATH","COMM","ENG"]
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
        cell.backgroundColor = UIColor.red // make cell more visible in our example project
        
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
    
    
    
    
}
