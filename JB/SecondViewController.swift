//
//  SecondViewController.swift
//  JB
//
//  Created by Raymond Li on 8/18/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit
class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var games = [GameStats]()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let game2 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game2)

        let game1 = GameStats(dl: "10/26/16 vs. Nets", p: 12, r: 2, a: 3, s: 4, b: 5, tSF: "6/10", tSP: 0.44, tPSF: "3/5", tPSP: 0.33, thPSF: "1/4", thPSP: 0.25, fTF: "10/11", turn: 3, scr: "W: 90-83", min: 22)
        games.append(game1)
        
        let game3 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game3)
        let game4 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game4)
        let game5 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game5)
        let game6 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game6)
        let game7 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game7)
        let game8 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game8)
        let game9 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game9)
        let game10 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game10)
        let game11 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game11)
        let game12 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game12)
        let game13 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game13)
        let game14 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game14)
        let game15 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game15)
        let game16 = GameStats(dl: "10/27/16 @ Bulls", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 100-98", min: 18)
        games.append(game16)
        let game17 = GameStats(dl: "Checkers", p: 10, r: 5, a: 3, s: 1, b: 2, tSF: "3/6", tSP: 0.5, tPSF: "2/3", tPSP: 0.66, thPSF: "1/3", thPSP: 0.33, fTF: "3/5", turn: 2, scr: "W: 1-0", min: 18)
        games.append(game17)
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("GameCell") as? GameCell {
            let totalPoints = String(games[indexPath.row].totalPoints)
            let totalRebounds = String(games[indexPath.row].totalRebounds)
            let totalAssists = String(games[indexPath.row].totalAssists)
            let totalSteals = String(games[indexPath.row].totalSteals)
            let totalBlocks = String(games[indexPath.row].totalBlocks)
            let totalShootingFraction = games[indexPath.row].totalShootingFraction
            
            let mainStats = totalPoints + "/" + totalRebounds + "/" + totalAssists + "/" + totalSteals + "/" + totalBlocks + " " + totalShootingFraction
            
            cell.configureCell(games[indexPath.row].dateLocation, gameStats: mainStats)
            
            return cell
        } else {
            return GameCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
}