//
//  ViewController.swift
//  Twittermenti
//
//  Created by Anthony Campbell on 01/15/2019.
//  Copyright © 2019 Anthony Campbell. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    private let sentimentClassifier = TweetSentimentClaassifier()
    
    private let swifter = Swifter(consumerKey: "", consumerSecret: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
            
            var tweets = [TweetSentimentClaassifierInput]()
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetSentimentClaassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }
            
            do {
                let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                
                var sentimentScore = 0
                
                for prediction in predictions {
                    let sentiment = prediction.label
                    
                    if sentiment == "Pos" {
                        sentimentScore += 1
                    } else if sentiment == "Neg" {
                        sentimentScore -= 1
                    }
                }
                
            } catch {
                print("There was an error with making a prediction, \(error)")
            }
           
            
            print(tweets)
            
        }) { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

