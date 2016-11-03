//
//  FirstViewController.swift
//  JB
//
//  Created by Raymond Li on 8/17/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, NSURLConnectionDelegate {
    
    @IBOutlet weak var nextGame: UILabel!
    
    var nextGameString: String! = "0"
    var nextGameDate: String! = "0"
    var nextGameTime: String! = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        nextGame.text = " "
        getNextGameJSON(gameLogURL: "https://api.seatgeek.com/2/events?performers.id=2088&per_page=25&client_id=MTIwNzV8MTM2NTQ1MDQyMg")
    }
    
    
    //Function that gets JSON data from the URL
    func getNextGameJSON(gameLogURL: String) {
        let url = URL(string: gameLogURL)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    //eventsList is an array of events
                    let eventsList: NSArray = json["events"] as! NSArray
                    //nextGameEvent is a dictionary
                    let nextGameEvent = eventsList[0] as! [String: Any]
                    
                    self.nextGameString = nextGameEvent["title"] as! String
                    let unformattedGameDate: String = nextGameEvent["datetime_local"] as! String
                    self.nextGameDate = self.formatGameDate(input: unformattedGameDate)
                    self.nextGameTime = self.formatGameTime(input: unformattedGameDate)
                    
                    DispatchQueue.main.async(execute: {
                        self.nextGame.text = "Next Game\n" + self.nextGameString + "\n" + self.nextGameDate + "\n" + self.nextGameTime
                    })
                } catch {
                    print("Could not serialize")
                }
            }
        }).resume()
    }
    
    func formatGameDate(input: String) -> String{
        let index1 = input.index(input.startIndex, offsetBy: 4)
        let year: String = input.substring(to: index1)
        
        let index2 = input.index(input.startIndex, offsetBy: 5)
        let index3 = input.index(input.startIndex, offsetBy: 7)
        let range1 = index2..<index3
        let month: String = input.substring(with: range1)
        
        let index4 = input.index(input.startIndex, offsetBy: 8)
        let index5 = input.index(input.startIndex, offsetBy: 10)
        let range2 = index4..<index5
        let date: String = input.substring(with: range2)
        return month + "/" + date + "/" + year
    }
    
    func formatGameTime(input: String) -> String {
        let index1 = input.index(input.startIndex, offsetBy: 14)
        let index2 = input.index(input.startIndex, offsetBy: 16)
        let range1 = index1..<index2
        let minute = input.substring(with: range1)
        
        let index3 = input.index(input.startIndex, offsetBy: 11)
        let index4 = input.index(input.startIndex, offsetBy: 13)
        let range2 = index3..<index4
        let hour1: String = input.substring(with: range2)
        print(hour1)
        var intHour: Int = Int(hour1)!
        var ampm: String = "AM"
        
        //Convert to PST
        intHour = intHour - 3
        
        if (intHour >= 12) {
            ampm = "PM"
        }
        if (intHour >= 13) {
            intHour = intHour - 12
        }
        let hour: String = String(describing: intHour)
        
        return hour + ":" + minute + " "  + ampm + " PST"
    }
}


