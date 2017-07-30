//
//  SeasonTable.swift
//  JB
//
//  Created by Raymond Li on 7/29/17.
//  Copyright © 2017 Raymond Li. All rights reserved.
//

import UIKit
class SeasonTable: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate {
    
    var seasons = [SeasonStats]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getSeasonJSON(gameLogURL: "http://stats.nba.com/stats/playercareerstats?LeagueID=00&PerMode=PerGame&PlayerID=1627759")
        tableView.reloadData()
    }
    
    
    //Function that gets JSON data from the URL
    func getSeasonJSON(gameLogURL: String) {
        let url = URL(string: gameLogURL)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    //resultSets is a dictionary
                    let resultSetsTemp: NSArray = json["resultSets"] as! NSArray
                    let resultSets = resultSetsTemp[0] as! [String: Any]
                    //rowSet is an array of arrays, where each subarray is a game
                    let rowSet: NSArray = resultSets["rowSet"] as! NSArray
                    let season: NSArray = rowSet[0] as! NSArray
                    
                    self.turnRowSetIntoSeasonStats(rowSet: season)
                    self.tableView.reloadData()
                } catch {
                    print("Could not serialize")
                }
            }
        }).resume()
    }
    
    
    func turnRowSetIntoSeasonStats(rowSet: NSArray) {
        var pointsDouble: Double = rowSet[26] as! Double
        pointsDouble = Double(round(1000 * pointsDouble) / 1000)
        let pointsString = String(describing: pointsDouble)
        
        let gamesString = String(describing: rowSet[6])
        let MPGString = String(describing: rowSet[8])
        let reboundsString = String(describing: rowSet[20])
        let assistsString = String(describing: rowSet[21])
        let stealsString = String(describing: rowSet[22])
        let blocksString = String(describing: rowSet[23])
        let turnoversString = String(describing: rowSet[24])
        let totalFGString = String(describing: rowSet[9]) + "/" + String(describing: rowSet[10])
        let totalFGPerString = String(describing: rowSet[11])
        let threePTString = String(describing: rowSet[12]) + "/" + String(describing: rowSet[13])
        let threePTPerString = String(describing: rowSet[14])
        let ftString = String(describing: rowSet[15]) + "/" + String(describing: rowSet[16])
        let ftPerString = String(describing: rowSet[17])
        
        /*
        let currentSeasonLabel = "Boston Celtics 2017-2018" + "\n\n" + "Games: " + gamesString + "\n" + "MPG: " + MPGString + "\n" + "Points: " + pointsString + "\n" + "Rebounds: " + reboundsString + "\n" + "Assists: " + assistsString + "\n" + "Steals: " + stealsString + "\n" + "Blocks: " + blocksString + "\n" + "Turnovers: " + turnoversString + "\n" + "Total FG: " + totalFGString + " = " + totalFGPerString + "\n" + "3PT FG: " + threePTString + " = " + threePTPerString + "\n" + "Free Throws: " + ftString + " = " + ftPerString
        */
        //Delete following label when season actually starts
        let currentSeasonLabel = "Boston Celtics: 2017-2018" + "\n\n" + "Games: 0\n" + "MPG: 0\n" + "Points: \n" + "Rebounds: \n" + "Assists: \n" + "Steals: \n" + "Blocks: \n" + "Turnovers: \n" + "Total FG: \n" + "3PT FG: \n" + "Free Throws: "
        let season17_18 = SeasonStats(type: "NBA", team: "Celtics", label: currentSeasonLabel)
        seasons.append(season17_18)
        
        appendSeasons()
    }

    
    func appendSeasons() {
        let season16_17_string = "Boston Celtics: 2016-2017" + "\n\n" + "Games: 78\n" + "MPG: 17.2\n" + "Points: 6.6\n" + "Rebounds: 2.8\n" + "Assists: 0.8\n" + "Steals: 0.4\n" + "Blocks: 0.2\n" + "Turnovers: 0.9\n" + "Total FG: 2.5/5.4 = 0.455\n" + "3PT FG: 0.6/1.7 = 0.343\n" + "Free Throws: 1.1/1.6 = 0.685"
        let season16_17 = SeasonStats(type: "NBA", team: "Celtics", label: season16_17_string)
        seasons.append(season16_17)
        
        let collegeSeason_string = "Cal Golden Bears: 2015-2016" + "\n\n" + "Games: 34\n" + "MPG: 27.6\n" + "Points: 14.6\n" + "Rebounds: 5.4\n" + "Assists: 2.0\n" + "Steals: 0.8\n" + "Blocks: 0.6\n" + "Turnovers: 3.1\n" + "Total FG: 4.8/11.1 = 0.431\n" + "3PT FG: 0.9/3.0 = 0.294\n" + "Free Throws: 4.2/6.4 = 0.654"
        let collegeSeason = SeasonStats(type: "College", team: "Cal", label: collegeSeason_string)
        seasons.append(collegeSeason)
        
        let HSSeason = SeasonStats(type: "HS", team: "Wheeler", label: "Wheeler HS" + "\n\n" + "Points: 28" + "\n\n" + "Rebounds: 12")
        seasons.append(HSSeason)
    }
    
    
    //Hides the navigation bar for the game log view.
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell") as? SeasonCell {
            cell.accessoryView?.backgroundColor = UIColor.black
            //Give disclosure indicator if NBA season
            if seasons[indexPath.row].type == "NBA" {
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            let seasonInfo = seasons[indexPath.row].label
            cell.configureCell(seasonInfo)
            
            //Sets cell background color
            if seasons[indexPath.row].team == "Celtics" {
                cell.backgroundColor = UIColor(red: 0, green: 0.9, blue: 0, alpha: 1)
            } else if seasons[indexPath.row].team == "Cal" {
                cell.backgroundColor = UIColor(red: 1, green: 0.843, blue: 0, alpha: 1)
            } else {
                cell.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1)
            }
            return cell
        } else {
            return SeasonCell()
        }
    }
    
    //Called when user taps on a cell. Performs segue if the cell is a game. Otherwise do nothing.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if seasons[indexPath.row].type == "NBA" {
            self.performSegue(withIdentifier: "showDetailedSeason", sender: self)
        } else {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Called before the segue is executed. Sets the labels of the detailed game view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailedSeason" {
            //let upcoming: DetailedSeasonVC = segue.destination as! DetailedSeasonVC
            let indexPath = self.tableView.indexPathForSelectedRow!

            //upcoming.shootingDetailsString = shootingDetailsLabel
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //We are using a one column table.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows is the length of the seasons array.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    
}

