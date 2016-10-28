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
    
    var gamesString: String! = "0"
    var MPGString: String! = "0"
    var pointsString: String! = "0"
    var reboundsString: String! = "0"
    var assistsString: String! = "0"
    var stealsString: String! = "0"
    var blocksString: String! = "0"
    var turnoversString: String! = "0"
    var totalFGString: String! = "0"
    var totalFGPerString: String! = "0"
    var threePTString: String! = "0"
    var threePTPerString: String! = "0"
    var ftString: String! = "0"
    var ftPerString: String! = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNBAJSON(gameLogURL: "http://stats.nba.com/stats/playercareerstats?LeagueID=00&PerMode=PerGame&PlayerID=1627759")
        
        //seasonStats.text = "Boston Celtics 2016-2017" + "\n\n" + "Games: " + gamesString + "\n" + "MPG: " + MPGString + "\n" + "Points: " + pointsString + "\n" + "Rebounds: " + reboundsString + "\n" + "Assists: " + assistsString + "\n" + "Steals: " + stealsString + "\n" + "Blocks: " + blocksString + "\n" + "Turnovers: " + turnoversString + "\n" + "Total FG: " + totalFGString + " = " + totalFGPerString + "\n" + "3PT FG: " + threePTString + " = " + threePTPerString + "\n" + "Free Throws: " + ftString + " = " + ftPerString
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        seasonStats.text = "Boston Celtics 2016-2017" + "\n\n" + "Games: " + gamesString + "\n" + "MPG: " + MPGString + "\n" + "Points: " + pointsString + "\n" + "Rebounds: " + reboundsString + "\n" + "Assists: " + assistsString + "\n" + "Steals: " + stealsString + "\n" + "Blocks: " + blocksString + "\n" + "Turnovers: " + turnoversString + "\n" + "Total FG: " + totalFGString + " = " + totalFGPerString + "\n" + "3PT FG: " + threePTString + " = " + threePTPerString + "\n" + "Free Throws: " + ftString + " = " + ftPerString
    }
    
    //Function that gets JSON data from the URL
    func getNBAJSON(gameLogURL: String) {
        let url = URL(string: gameLogURL)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if let responseData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    //resultSets is a dictionary
                    let resultSetsTemp: NSArray = json["resultSets"] as! NSArray
                    let resultSets = resultSetsTemp[0] as! [String: Any]
                    //rowSet is an array of arrays, where each subarray is a game
                    let rowSet: NSArray = resultSets["rowSet"] as! NSArray
                    let season: NSArray = rowSet[0] as! NSArray
                    
                    self.turnRowSetIntoSeasonStats(rowSet: season)
                } catch {
                    print("Could not serialize")
                }
            }
        }).resume()
    }
    
    //Function that gets JSON data from the URL
    func getSeasonJSON(_ gameLogURL: String) {
        let mySession = URLSession.shared
        let url: URL = URL(string: gameLogURL)!
        print("doob")
        mySession.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: NSError?) -> Void in
            print("chess")
            if let responseData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSMutableDictionary
                    //resultSets is a dictionary
                    let resultsSetsTemp: NSArray = json["resultsSets"] as! NSArray
                    let resultSets: NSMutableDictionary = resultsSetsTemp[0] as! NSMutableDictionary
                    //rowSet is an array of size 1 containing an array of size 1 of season stats
                    let rowSet: NSArray = resultSets["rowSet"] as! NSArray
                    let season: NSArray = rowSet[0] as! NSArray
                    self.turnRowSetIntoSeasonStats(rowSet: season)
                    
                    DispatchQueue.main.async(execute: {
                        self.reloadInputViews()
                    })
                    
                } catch {
                    print("Could not serialize")
                }
            }
        } as! (Data?, URLResponse?, Error?) -> Void) .resume()
    }
    
    func turnRowSetIntoSeasonStats(rowSet: NSArray) {
        gamesString = String(describing: rowSet[6])
        MPGString = String(describing: rowSet[8])
        pointsString = String(describing: rowSet[26])
        reboundsString = String(describing: rowSet[20])
        assistsString = String(describing: rowSet[21])
        stealsString = String(describing: rowSet[22])
        blocksString = String(describing: rowSet[23])
        turnoversString = String(describing: rowSet[24])
        totalFGString = String(describing: rowSet[9]) + "/" + String(describing: rowSet[10])
        totalFGPerString = String(describing: rowSet[11])
        threePTString = String(describing: rowSet[12]) + "/" + String(describing: rowSet[13])
        threePTPerString = String(describing: rowSet[14])
        ftString = String(describing: rowSet[15]) + "/" + String(describing: rowSet[16])
        ftPerString = String(describing: rowSet[17])
    }
}
