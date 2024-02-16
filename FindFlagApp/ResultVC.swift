//
//  ResultVC.swift
//  FindFlagApp
//
//  Created by Nebula on 23.10.23.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var results: UILabel!
    
    var correctNumber:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        if let c = correctNumber {
            results.text = "Correct \(c) & Incorrect \(5-c)"
        }
        
    }
    @IBAction func TryAgain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
