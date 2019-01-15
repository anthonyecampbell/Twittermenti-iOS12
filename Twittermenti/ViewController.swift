//
//  ViewController.swift
//  Twittermenti
//
//  Created by Anthony Campbell on 01/15/2019.
//  Copyright © 2019 Anthony Campbell. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: "", consumerSecret: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            print(results)
        }) { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

