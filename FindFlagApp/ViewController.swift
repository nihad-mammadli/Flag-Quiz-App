//
//  ViewController.swift
//  FindFlagApp
//
//  Created by Nebula on 23.10.23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        copyDataBase()
    }


    
}


func copyDataBase() {
    
    let fileManager = FileManager.default
    
    let bundlePath = Bundle.main.path(forResource: "flags", ofType: ".db")
    
    let endpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    let copyLocation = URL(fileURLWithPath: endpath).appendingPathComponent("flags.db")
    
    if fileManager.fileExists(atPath: copyLocation.path) {
        print("DB already exists")
    }else{
        do {
            try fileManager.copyItem(atPath: bundlePath!, toPath: copyLocation.path)
        } catch {
            print(error)
        }
    }
}

