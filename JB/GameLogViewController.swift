//
//  SecondViewController.swift
//  JB
//
//  Created by Raymond Li on 8/18/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit
class GameLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var games = [GameStats]()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
 
        getNBAJSON(gameLogURL: "http://stats.nba.com/stats/playergamelog?DateFrom=&DateTo=&LeagueID=00&PlayerID=1627759&Season=2017-18&SeasonType=Regular+Season")

        tableView.reloadData()
    }
    
    //Function that gets JSON data from the URL
    func getNBAJSON(gameLogURL: String) {
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
                    
                    self.turnRowSetIntoGameStats(rowSet)
                    
                    DispatchQueue.main.async(execute: {
                        self.tableView!.reloadData()
                    })
                } catch {
                    print("Could not serialize")
                }
            }
        }).resume()
    }
    
    func turnRowSetIntoGameStats(_ rowSet: NSArray) {
        //rowSet is an array of arrays, where each subarray is a game. Turn each game into a GameStats
        var i: Int = 0
        while i < rowSet.count {
            //Start at i = 0, so rowSet[0] is the first game array. Continue until last game.
            let currentGame: NSArray = rowSet[i] as! NSArray
            let gameInfo = self.getGameInfo(currentGame[3] as! String, opponent: currentGame[4] as! String)
            let gameNumber = String(rowSet.count - i)
            let score = String(describing: currentGame[5])
            let points = String(describing: currentGame[24])
            let rebounds = String(describing: currentGame[18])
            let assists = String(describing: currentGame[19])
            let steals = String(describing: currentGame[20])
            let blocks = String(describing: currentGame[21])
            
            let FGM: String = String(describing: currentGame[7])
            let FGA: String = String(describing: currentGame[8])
            
            let totalShoot = FGM + "/" + FGA
            let totalShootP = String(describing: currentGame[9])
            
            
            let twoPointersMade =  (currentGame[7] as! Int) - (currentGame[10] as! Int)
            let twoPointersAttempted = (currentGame[8] as! Int) - (currentGame[11] as! Int)
            let twoF = String(twoPointersMade) + "/" + String(twoPointersAttempted)
            let twoPtDouble = Double(twoPointersMade) / Double(twoPointersAttempted)
            let twoPtRounded = Double(round(twoPtDouble * 1000) / 1000)
            let twoP = String(twoPtRounded)
            
            let threeF = String(describing: currentGame[10]) + "/" + String(describing: currentGame[11])
            let threeP = String(describing: currentGame[12])
            
            let fF = String(describing: currentGame[13]) + "/" + String(describing: currentGame[14])
            let fP = String(describing: currentGame[15])
            
            let turnovers = String(describing: currentGame[22])
            let minutes = String(describing: currentGame[6])
            let fouls = String(describing: currentGame[23])
            let offensiveRebounds = String(describing: currentGame[16])
            let defensiveRebounds = String(describing: currentGame[17])
            let plus_minus = String(describing: currentGame[25])
            
            //Create a new GameStats and append it to games. So first element in games will be first element in rowSet, which is the most recent game.
            let newGame = GameStats(label: "game", dl: gameInfo, gN: gameNumber, scr: score, bgR: 0, bgG: 0.9, bgB: 0, bgA: 1, p: points, r: rebounds, a: assists, s: steals, b: blocks, tSF: totalShoot, tSP: totalShootP, tPSF: twoF, tPSP: twoP, thPSF: threeF, thPSP: threeP, fTF: fF, ftP: fP, turn: turnovers, min: minutes, foul: fouls, oReb: offensiveRebounds, dReb: defensiveRebounds, pM: plus_minus)
            self.games.append(newGame)
            
            i = i + 1
        }
        //After adding NBA games, add all college games to games array.
        //addCollegeGames()
    }
    
    func addCollegeGames() {
        //Manually adds each game array.
        
        //Blank row is an empty black row to act as a separator.
        let blankRow = GameStats(bgR: 0, bgG: 0, bgB: 0, bgA: 1)
        games.append(blankRow)
        
        let CalHeader = GameStats(label: "College Games", dl: "California        ", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1)
        games.append(CalHeader)
        
        let CalGame34 = GameStats(label: "game", dl: "3/18/16 vs. Hawaii", gN: "34", scr: "L: 66-77", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "4", r: "2", a: "0", s: "0", b: "0", tSF: "1/6", tSP: "0.167", tPSF: "1/4", tPSP: "0.25", thPSF: "0/2", thPSP: "0.0", fTF: "2/2", turn: "7", min: "17", foul: "5")
        games.append(CalGame34)
        
        let CalGame33 = GameStats(label: "game", dl: "3/11/16 @ Utah", gN: "33", scr: "L: 78-82 (OT)", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "12", r: "5", a: "5", s: "2", b: "0", tSF: "3/17", tSP: "0.176", tPSF: "3/14", tPSP: "0.214", thPSF: "0/3", thPSP: "0.00", fTF: "6/8", turn: "1", min: "32", foul: "4")
        games.append(CalGame33)
        
        let CalGame32 = GameStats(label: "game", dl: "3/10/16 vs. Oregon State", gN: "32", scr: "W: 76-68", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "8", r: "2", a: "3", s: "4", b: "1", tSF: "1/6", tSP: "0.167", tPSF: "0/3", tPSP: "0.00", thPSF: "1/3", thPSP: "0.333", fTF: "5/7", turn: "6", min: "31", foul: "3")
        games.append(CalGame32)
        
        let CalGame31 = GameStats(label: "game", dl: "3/5/16 @ Arizona State", gN: "31", scr: "W: 68-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "10", r: "6", a: "2", s: "2", b: "0", tSF: "3/10", tSP: "0.30", tPSF: "3/7", tPSP: "0.429", thPSF: "0/3", thPSP: "0.00", fTF: "4/6", turn: "2", min: "31", foul: "3")
        games.append(CalGame31)
        
        let CalGame30 = GameStats(label: "game", dl: "3/3/16 @ Arizona", gN: "30", scr: "L: 61-64", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "5", r: "1", a: "1", s: "0", b: "1", tSF: "2/9", tSP: "0.222", tPSF: "1/8", tPSP: "0.125", thPSF: "1/1", thPSP: "1.00", fTF: "0/0", turn: "2", min: "15", foul: "5")
        games.append(CalGame30)
        
        let CalGame29 = GameStats(label: "game", dl: "2/28/16 vs. USC", gN: "29", scr: "W: 87-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "18", r: "8", a: "2", s: "0", b: "2", tSF: "6/12", tSP: "0.50", tPSF: "3/5", tPSP: "0.60", thPSF: "3/7", thPSP: "0.429", fTF: "3/7", turn: "2", min: "32", foul: "3")
        games.append(CalGame29)
        
        let CalGame28 = GameStats(label: "game", dl: "2/25/16 vs. UCLA", gN: "28", scr: "W: 75-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "10", a: "3", s: "0", b: "1", tSF: "5/10", tSP: "0.50", tPSF: "3/6", tPSP: "0.50", thPSF: "2/4", thPSP: "0.50", fTF: "4/5", turn: "4", min: "33", foul: "1")
        games.append(CalGame28)
        
        let CalGame27 = GameStats(label: "game", dl: "2/21/16 @ Washington State", gN: "27", scr: "W: 80-62", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "8", r: "6", a: "1", s: "0", b: "1", tSF: "3/6", tSP: "0.50", tPSF: "2/4", tPSP: "0.50", thPSF: "1/2", thPSP: "0.50", fTF: "1/2", turn: "2", min: "27", foul: "2")
        games.append(CalGame27)
        
        let CalGame26 = GameStats(label: "game", dl: "2/18/16 @ Washington", gN: "26", scr: "W: 78-75", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "23", r: "5", a: "0", s: "2", b: "1", tSF: "7/13", tSP: "0.538", tPSF: "6/10", tPSP: "0.60", thPSF: "1/3", thPSP: "0.333", fTF: "8/10", turn: "3", min: "31", foul: "3")
        games.append(CalGame26)
        
        let CalGame25 = GameStats(label: "game", dl: "2/13/16 vs. Oregon State", gN: "25", scr: "W: 83-71", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "15", r: "7", a: "3", s: "1", b: "1", tSF: "5/11", tSP: "0.455", tPSF: "4/8", tPSP: "0.50", thPSF: "1/3", thPSP: "0.333", fTF: "4/7", turn: "4", min: "30", foul: "4")
        games.append(CalGame25)
        
        let CalGame24 = GameStats(label: "game", dl: "2/11/16 vs. Oregon", gN: "24", scr: "W: 83-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "4", a: "4", s: "1", b: "1", tSF: "7/16", tSP: "0.438", tPSF: "5/13", tPSP: "0.385", thPSF: "2/3", thPSP: "0.667", fTF: "0/3", turn: "1", min: "33", foul: "1")
        games.append(CalGame24)
        
        let CalGame23 = GameStats(label: "game", dl: "2/6/16 vs. Stanford", gN: "23", scr: "W: 76-61", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "3", a: "2", s: "0", b: "1", tSF: "4/12", tSP: "0.333", tPSF: "4/10", tPSP: "0.40", thPSF: "0/2", thPSP: "0.00", fTF: "8/12", turn: "2", min: "27", foul: "3")
        games.append(CalGame23)
        
        let CalGame22 = GameStats(label: "game", dl: "1/31/16 @ Colorado", gN: "22", scr: "L: 62-70", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "21", r: "6", a: "2", s: "0", b: "1", tSF: "6/15", tSP: "0.40", tPSF: "5/12", tPSP: "0.417", thPSF: "1/3", thPSP: "0.333", fTF: "8/11", turn: "4", min: "26", foul: "4")
        games.append(CalGame22)
        
        let CalGame21 = GameStats(label: "game", dl: "1/27/16 @ Utah", gN: "21", scr: "L: 64-73", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "27", r: "3", a: "2", s: "2", b: "0", tSF: "9/20", tSP: "0.450", tPSF: "8/15", tPSP: "0.533", thPSF: "1/5", thPSP: "0.20", fTF: "8/10", turn: "4", min: "33", foul: "3")
        games.append(CalGame21)
        
        let CalGame20 = GameStats(label: "game", dl: "1/23/16 vs. Arizona", gN: "20", scr: "W: 74-73", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "15", r: "4", a: "7", s: "1", b: "2", tSF: "4/16", tSP: "0.25", tPSF: "4/12", tPSP: "0.333", thPSF: "0/4", thPSP: "0.00", fTF: "7/11", turn: "3", min: "35", foul: "1")
        games.append(CalGame20)
        
        let CalGame19 = GameStats(label: "game", dl: "1/21/16 vs. Arizona State", gN: "19", scr: "W: 75-70", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "2", a: "2", s: "1", b: "1", tSF: "5/7", tSP: "0.714", tPSF: "4/5", tPSP: "0.80", thPSF: "1/2", thPSP: "0.50", fTF: "6/8", turn: "2", min: "20", foul: "5")
        games.append(CalGame19)
        
        let CalGame18 = GameStats(label: "game", dl: "1/14/16 @ Stanford", gN: "18", scr: "L: 71-77", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "13", r: "1", a: "2", s: "2", b: "0", tSF: "3/7", tSP: "0.429", tPSF: "2/4", tPSP: "0.50", thPSF: "1/3", thPSP: "0.333", fTF: "6/9", turn: "3", min: "22")
        games.append(CalGame18)
        
        let CalGame17 = GameStats(label: "game", dl: "1/9/16 @ Oregon State", gN: "17", scr: "L: 71-77", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "20", r: "7", a: "2", s: "0", b: "2", tSF: "8/13", tSP: "0.615", tPSF: "6/9", tPSP: "0.667", thPSF: "2/4", thPSP: "0.50", fTF: "2/8", turn: "4", min: "35", foul: "4")
        games.append(CalGame17)
        
        let CalGame16 = GameStats(label: "game", dl: "1/6/16 @ Oregon", gN: "16", scr: "L: 65-68", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "20", r: "9", a: "0", s: "2", b: "1", tSF: "8/10", tSP: "0.80", tPSF: "8/8", tPSP: "1.00", thPSF: "0/2", thPSP: "0.00", fTF: "4/6", turn: "4", min: "35", foul: "1")
        games.append(CalGame16)
        
        let CalGame15 = GameStats(label: "game", dl: "1/3/16 vs. Utah", gN: "15", scr: "W: 71-58", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "9", r: "7", a: "4", s: "0", b: "0", tSF: "4/11", tSP: "0.364", tPSF: "3/9", tPSP: "0.333", thPSF: "1/2", thPSP: "0.50", fTF: "0/0", turn: "4", min: "28", foul: "2")
        games.append(CalGame15)
        
        let CalGame14 = GameStats(label: "game", dl: "1/1/16 vs. Colorado", gN: "14", scr: "W: 79-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "11", a: "2", s: "0", b: "1", tSF: "6/8", tSP: "0.75", tPSF: "5/6", tPSP: "0.833", thPSF: "1/2", thPSP: "0.50", fTF: "4/4", turn: "2", min: "33", foul: "3")
        games.append(CalGame14)
        
        let CalGame13 = GameStats(label: "game", dl: "12/28/15 vs. Davidson", gN: "13", scr: "W: 86-60", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "7", a: "2", s: "0", b: "1", tSF: "7/8", tSP: "0.875", tPSF: "6/6", tPSP: "1.00", thPSF: "1/2", thPSP: "0.50", fTF: "2/4", turn: "6", min: "20", foul: "3")
        games.append(CalGame13)
        
        let CalGame12 = GameStats(label: "game", dl: "12/22/15 @ Virginia", gN: "12", scr: "L: 62-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "18", r: "6", a: "1", s: "0", b: "0", tSF: "5/11", tSP: "0.455", tPSF: "5/8", tPSP: "0.625", thPSF: "0/3", thPSP: "0.00", fTF: "8/9", turn: "4", min: "31", foul: "3")
        games.append(CalGame12)
        
        let CalGame11 = GameStats(label: "game", dl: "1/19/15 vs. Coppin State", gN: "11", scr: "W: 84-51", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "10", r: "6", a: "5", s: "0", b: "2", tSF: "4/10", tSP: "0.40", tPSF: "3/8", tPSP: "0.375", thPSF: "1/2", thPSP: "0.50", fTF: "1/2", turn: "4", min: "29", foul: "3")
        games.append(CalGame11)
        
        let CalGame10 = GameStats(label: "game", dl: "12/12/15 vs. Saint Mary's", gN: "10", scr: "W: 63-59", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "11", r: "3", a: "2", s: "1", b: "1", tSF: "3/9", tSP: "0.333", tPSF: "2/6", tPSP: "0.333", thPSF: "1/3", thPSP: "0.333", fTF: "4/8", turn: "3", min: "26", foul: "2")
        games.append(CalGame10)
        
        let CalGame9 = GameStats(label: "game", dl: "12/9/15 vs. Incarnate Word", gN: "9", scr: "W: 74-62", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "13", r: "4", a: "1", s: "1", b: "0", tSF: "5/13", tSP: "0.385", tPSF: "4/9", tPSP: "0.444", thPSF: "1/4", thPSP: "0.25", fTF: "2/4", turn: "2", min: "25", foul: "4")
        games.append(CalGame9)
        
        let CalGame8 = GameStats(label: "game", dl: "12/5/15 @ Wyoming", gN: "8", scr: "W: 78-72", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "9", r: "4", a: "0", s: "1", b: "0", tSF: "2/8", tSP: "0.25", tPSF: "1/6", tPSP: "0.167", thPSF: "1/2", thPSP: "0.50", fTF: "4/6", turn: "3", min: "29", foul: "5")
        games.append(CalGame8)
        
        let CalGame7 = GameStats(label: "game", dl: "1/1/15 vs. Seattle", gN: "7", scr: "W: 66-52", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "11", r: "7", a: "0", s: "1", b: "0", tSF: "3/13", tSP: "0.231", tPSF: "2/11", tPSP: "0.182", thPSF: "1/2", thPSP: "0.50", fTF: "4/6", turn: "2", min: "28", foul: "4")
        games.append(CalGame7)
        
        let CalGame6 = GameStats(label: "game", dl: "11/27/15 vs. Richmond", gN: "6", scr: "L: 90-94", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "27", r: "3", a: "0", s: "0", b: "0", tSF: "11/16", tSP: "0.688", tPSF: "11/13", tPSP: "0.846", thPSF: "0/3", thPSP: "0.00", fTF: "5/7", turn: "3", min: "33", foul: "4")
        games.append(CalGame6)
        
        let CalGame5 = GameStats(label: "game", dl: "11/26/15 @ San Diego State", gN: "5", scr: "L: 58-72", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "7", r: "3", a: "0", s: "0", b: "1", tSF: "2/8", tSP: "0.25", tPSF: "1/5", tPSP: "0.20", thPSF: "1/3", thPSP: "0.333", fTF: "2/4", turn: "3", min: "16", foul: "5")
        games.append(CalGame5)
        
        let CalGame4 = GameStats(label: "game", dl: "11/23/15 vs. Sam Houston State", gN: "4", scr: "W: 89-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "18", r: "11", a: "4", s: "2", b: "0", tSF: "6/10", tSP: "0.60", tPSF: "6/7", tPSP: "0.857", thPSF: "0/3", thPSP: "0.00", fTF: "6/8", turn: "1", min: "28", foul: "2")
        games.append(CalGame4)
        
        let CalGame3 = GameStats(label: "game", dl: "11/20/15 vs. East Carolina", gN: "3", scr: "W: 70-62", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "10", a: "2", s: "0", b: "0", tSF: "4/12", tSP: "0.333", tPSF: "4/7", tPSP: "0.571", thPSF: "0/5", thPSP: "0.00", fTF: "8/14", turn: "3", min: "32", foul: "3")
        games.append(CalGame3)
        
        let CalGame2 = GameStats(label: "game", dl: "11/16/15 vs. UCSB", gN: "2", scr: "W: 85-67", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "7", a: "0", s: "1", b: "0", tSF: "6/10", tSP: "0.60", tPSF: "5/7", tPSP: "0.714", thPSF: "1/3", thPSP: "0.333", fTF: "4/7", turn: "4", min: "21", foul: "2")
        games.append(CalGame2)
        
        let CalGame1 = GameStats(label: "game", dl: "11/13/15 vs. Rice", gN: "1", scr: "W: 97-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "14", r: "1", a: "2", s: "0", b: "0", tSF: "5/15", tSP: "0.333", tPSF: "3/11", tPSP: "0.273", thPSF: "2/4", thPSP: "0.50", fTF: "2/2", ftP: "1.00", turn: "1", min: "15", foul: "4")
        games.append(CalGame1)
    }
    
    //Function called in turnRowSetIntoGameStats that turns format FEB 09, 2016 GSW vs. DAL into form 2/9/16 vs. DAL through subsetting strings.
    func getGameInfo(_ date: String, opponent: String) -> String {
        let oppIndex = opponent.characters.index(opponent.startIndex, offsetBy: 4)
        let trunOpp = opponent.substring(from: oppIndex)
        
        let day = date.substring(with: (date.characters.index(date.startIndex, offsetBy: 4) ..< date.characters.index(date.endIndex, offsetBy: -6)))
        let year = date.substring(from: date.characters.index(date.endIndex, offsetBy: -2))
        
        let writtenMonth = date.substring(to: date.characters.index(date.startIndex, offsetBy: 3))
        let numberMonth: String
        
        if writtenMonth == "JAN" {
            numberMonth = "1"
        } else if writtenMonth == "FEB" {
            numberMonth = "2"
        } else if writtenMonth == "MAR" {
            numberMonth = "3"
        } else if writtenMonth == "APR" {
            numberMonth = "4"
        } else if writtenMonth == "MAY" {
            numberMonth = "5"
        } else if writtenMonth == "JUN" {
            numberMonth = "6"
        } else if writtenMonth == "JUL" {
            numberMonth = "7"
        } else if writtenMonth == "AUG" {
            numberMonth = "8"
        } else if writtenMonth == "SEP" {
            numberMonth = "9"
        } else if writtenMonth == "OCT" {
            numberMonth = "10"
        } else if writtenMonth == "NOV" {
            numberMonth = "11"
        } else if writtenMonth == "DEC" {
            numberMonth = "12"
        } else {
            numberMonth = "0"
        }
        
        let numberedDate = numberMonth + "/" + day + "/" + year
        
        return numberedDate + " " + trunOpp
    }
    
    //Hides the navigation bar for the game log view.
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameCell {
            cell.accessoryView?.backgroundColor = UIColor.black
            //Check if cell needs to be game. If so, load labels with appropriate text.
            if games[indexPath.row].label == "game" {
                let totalPoints = games[indexPath.row].totalPoints
                let totalRebounds = games[indexPath.row].totalRebounds
                let totalAssists = games[indexPath.row].totalAssists
                let totalSteals = games[indexPath.row].totalSteals
                let totalBlocks = games[indexPath.row].totalBlocks
                let totalShootingFraction = games[indexPath.row].totalShootingFraction
                
                let mainStats = totalPoints + "/" + totalRebounds + "/" + totalAssists + "/" + totalSteals + "/" + totalBlocks
                
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
                cell.configureCell(games[indexPath.row].dateLocation, gameMainStats: mainStats, gameShootingF: totalShootingFraction)
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
                cell.configureCell(games[indexPath.row].label, gameMainStats: games[indexPath.row].dateLocation, gameShootingF: "")
            }
            
            //Sets cell background color
            cell.backgroundColor = UIColor(red: games[indexPath.row].backgroundRed, green: games[indexPath.row].backgroundGreen, blue: games[indexPath.row].backgroundBlue, alpha: games[indexPath.row].backgroundAlpha)
            
            return cell
        } else {
            return GameCell()
        }
    }
    
    //Called when user taps on a cell. Performs segue if the cell is a game. Otherwise do nothing.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if games[indexPath.row].label == "game" {
            self.performSegue(withIdentifier: "showDetailedGame", sender: self)
        } else {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Called before the segue is executed. Sets the labels of the detailed game view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailedGame" {
            let upcoming: DetailedGameVC = segue.destination as! DetailedGameVC
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let dateLocation = games[indexPath.row].dateLocation
            let gameNumber = games[indexPath.row].gameNumber
            let score = games[indexPath.row].score
            
            let totalPoints = games[indexPath.row].totalPoints
            let totalRebounds = games[indexPath.row].totalRebounds
            let totalAssists = games[indexPath.row].totalAssists
            let totalSteals = games[indexPath.row].totalSteals
            let totalBlocks = games[indexPath.row].totalBlocks
            
            let totalShootingFraction = games[indexPath.row].totalShootingFraction
            let totalShootingPercentage = games[indexPath.row].totalShootingPercentage
            let twoPointShootingFraction = games[indexPath.row].twoPointShootingFraction
            let twoPointShootingPercentage = games[indexPath.row].twoPointShootingPercentage
            let threePointShootingFraction = games[indexPath.row].threePointShootingFraction
            let threePointShootingPercentage = games[indexPath.row].threePointShootingPercentage
            let freeThrowFraction = games[indexPath.row].freeThrowFraction
            let freeThrowPercentage = games[indexPath.row].freeThrowPercentage
            
            let turnovers = games[indexPath.row].turnovers
            let minutes = games[indexPath.row].minutes
            let fouls = games[indexPath.row].fouls
            let offensiveRebounds = games[indexPath.row].offensiveRebounds
            let defensiveRebounds = games[indexPath.row].defensiveRebounds
            let plusMinus = games[indexPath.row].plusMinus
            

            
            let pointsLabel = "Points: " + totalPoints
            let reboundsLabel = "Rebounds: " + totalRebounds
            let assistsLabel = "Assists: " + totalAssists
            let stealsLabel = "Steals: " + totalSteals
            let blocksLabel = "Blocks: " + totalBlocks
            
            let tSFLabel = "Total Shooting Fraction: " + totalShootingFraction
            let tSPLabel = "Total Shooting Percentage: " + totalShootingPercentage
            let twoPtSFLabel = "2PT Shooting Fraction: " + twoPointShootingFraction
            let twoPtSPLabel = "2PT Shooting Percentage: " + twoPointShootingPercentage
            let threePtSFLabel = "3PT Shooting Fraction: " + threePointShootingFraction
            let threePtSPLabel = "3PT Shooting Percentage: " + threePointShootingPercentage
            let freeThrowFLabel = "Free Throws Fraction: " + freeThrowFraction
            let freeThrowPLabel = "Free Throws Percentage: " + freeThrowPercentage
            
            let minutesLabel = "Minutes: " + minutes
            let turnoversLabel = "Turnovers: " + turnovers
            let foulsLabel = "Fouls: " + fouls
            let oRebLabel = "Offensive Rebounds: " + offensiveRebounds
            let dRebLabel = "Defensive Rebounds: " + defensiveRebounds
            let plusMinusLabel = "Plus Minus: " + plusMinus

            
            let titleLabel = "Game " + gameNumber + "\n" + dateLocation + "\n" + score
            let mainStatsLabel = pointsLabel + "\n\n" + reboundsLabel + "\n\n" + assistsLabel + "\n\n" + stealsLabel + "\n\n" + blocksLabel
            let additionalStatsLabel = minutesLabel + "\n\n" + turnoversLabel + "\n\n" + foulsLabel + "\n\n" + oRebLabel + "\n\n" + dRebLabel + "\n\n" + plusMinusLabel
            let shootingDetailsLabel = tSFLabel + "\n" + tSPLabel + "\n\n" + freeThrowFLabel + "\n" + freeThrowPLabel + "\n\n" + twoPtSFLabel + "\n" + twoPtSPLabel + "\n\n" + threePtSFLabel + "\n" + threePtSPLabel
            
            upcoming.gameInfoString = titleLabel
            upcoming.mainStatsString = mainStatsLabel
            upcoming.additionalStatsString = additionalStatsLabel
            upcoming.shootingDetailsString = shootingDetailsLabel
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //We are using a one column table.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows is the length of the games array.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
}
