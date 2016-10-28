//
//  SeasonStatsViewController.swift
//  JB
//
//  Created by Raymond Li on 8/19/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit

class SeasonStatsViewController: UIViewController, NSURLConnectionDelegate {
    
    @IBOutlet weak var seasonStats: UILabel!
    
    var gamesString: String! = "default"
    var MPGString: String!
    var pointsString: String!
    var reboundsString: String!
    var assistsString: String!
    var stealsString: String!
    var blocksString: String!
    var turnoversString: String!
    var totalFGString: String!
    var totalFGPerString: String!
    var threePTString: String!
    var threePTPerString: String!
    var ftString: String!
    var ftPerString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSeasonJSON("http://stats.nba.com/stats/playercareerstats?LeagueID=00&PerMode=PerGame&PlayerID=1627759")
        print("Curry")
        seasonStats.text = gamesString
        //seasonStats.text = "Boston Celtics 2016-2017" + "\n\n" + "Games: " + gamesString + "\n" + "MPG: " + MPGString + "\n" + "Points: " + pointsString + "\n" + "Rebounds: " + reboundsString + "\n" + "Assists: " + assistsString + "\n" + "Steals: " + stealsString + "\n" + "Blocks: " + blocksString + "\n" + "Turnovers: " + turnoversString + "\n" + "Total FG: " + totalFGString + " = " + totalFGPerString + "\n" + "3PT FG: " + threePTString + " = " + threePTPerString + "\n" + "Free Throws: " + ftString + " = " + ftPerString
    }

    
    //Function that gets JSON data from the URL
    func getSeasonJSON(gameLogURL: String) {
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: gameLogURL)!
        print("doob")
        mySession.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print("chess")
            if let responseData = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments) as! NSMutableDictionary
                    //resultSets is a dictionary
                    let resultSets: NSMutableDictionary = json["resultSets"]![0] as! NSMutableDictionary
                    //rowSet is an array of size 1 containing an array of size 1 of season stats
                    let rowSet: NSArray = resultSets["rowSet"] as! NSArray
                    self.turnRowSetIntoSeasonStats(rowSet)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.reloadInputViews()
                    })
                    
                } catch {
                    print("Could not serialize")
                }
            }
        }.resume()
    }
    
    func turnRowSetIntoSeasonStats(rowSet: NSArray) {
        print("rrrrr")
        gamesString = String(rowSet[0][6])
        MPGString = String(rowSet[0][8])
        pointsString = String(rowSet[0][26])
        reboundsString = String(rowSet[0][20])
        assistsString = String(rowSet[0][21])
        stealsString = String(rowSet[0][22])
        blocksString = String(rowSet[0][23])
        turnoversString = String(rowSet[0][24])
        totalFGString = String(rowSet[0][9]) + "/" + String(rowSet[0][10])
        totalFGPerString = String(rowSet[0][11])
        threePTString = String(rowSet[0][12]) + "/" + String(rowSet[0][13])
        threePTPerString = String(rowSet[0][14])
        ftString = String(rowSet[0][15]) + "/" + String(rowSet[0][16])
        ftPerString = String(rowSet[0][17])
    }
}
