//: Playground - noun: a place where people can play

import UIKit

import Foundation

if let fileURL = Bundle.main.url(forResource:"Courses", withExtension: ".txt")
{
    do {
        let contents = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
        print(contents)
    } catch {
        print("Error: \(error)")
    }
} else {
    print("No such file URL.")
}

//File is read in as one big string --- name is contents ---
//Now just have to parse that string and add what we need to cloudkit database 

