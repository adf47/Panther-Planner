//
//  ClassCollectionViewCell.swift
//  iCourse Catalog
//
//  Created by Antonino Febbraro on 3/6/17.
//  Copyright © 2017 Antonino Febbraro. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var courseNum: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var times: UILabel!
    @IBOutlet weak var professor: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    
    @IBOutlet weak var bookmarkSearch: UIButton!
    @IBOutlet weak var bookmarkCred: UIButton!
    var classNum = ""
}
