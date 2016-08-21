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
        
        let season1Game2 = GameStats(label: "game", dl: "10/27/16 @ Bulls", gN: "2", scr: "W: 100-98", bgR: 0, bgG: 0.9, bgB: 0, bgA: 1, p: "10", r: "5", a: "3", s: "1", b: "2", tSF: "3/6", tSP: "0.5", tPSF: "2/3", tPSP: "0.66", thPSF: "1/3", thPSP: "0.33", fTF: "3/5", turn: "2", min: "18", foul: "2", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(season1Game2)

        let season1Game1 = GameStats(label: "game", dl: "10/26/16 vs. Nets", gN: "1", scr: "W: 90-83", bgR: 0, bgG: 0.9, bgB: 0, bgA: 1, p: "12", r: "2", a: "3", s: "4", b: "5", tSF: "6/10", tSP: "0.44", tPSF: "3/5", tPSP: "0.33", thPSF: "1/4", thPSP: "0.25", fTF: "10/11", turn: "3", min: "22", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(season1Game1)
        
        let blankRow = GameStats()
        games.append(blankRow)
        
        let CalHeader = GameStats(label: "College Games", secondaryLabel: "California        ", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1)
        games.append(CalHeader)
        
        let CalGame34 = GameStats(label: "game", dl: "3/18/16 vs. Hawaii", gN: "34", scr: "L: 66-77", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "4", r: "2", a: "0", s: "0", b: "0", tSF: "1/6", tSP: "0.167", tPSF: "1/4", tPSP: "0.25", thPSF: "0/2", thPSP: "0.0", fTF: "2/2", turn: "7", min: "17", foul: "5", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "0")
        games.append(CalGame34)
        
        let CalGame33 = GameStats(label: "game", dl: "3/11/16 @ Utah", gN: "33", scr: "L: 78-82 (OT)", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "12", r: "5", a: "5", s: "2", b: "0", tSF: "3/17", tSP: "0.176", tPSF: "3/14", tPSP: "0.214", thPSF: "0/3", thPSP: "0.00", fTF: "6/8", turn: "1", min: "32", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "0")
        games.append(CalGame33)
        
        let CalGame32 = GameStats(label: "game", dl: "3/10/16 vs. Oregon State", gN: "32", scr: "W: 76-68", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "8", r: "2", a: "3", s: "4", b: "1", tSF: "1/6", tSP: "0.167", tPSF: "0/3", tPSP: "0.00", thPSF: "1/3", thPSP: "0.333", fTF: "5/7", turn: "6", min: "31", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame32)
        
        let CalGame31 = GameStats(label: "game", dl: "3/5/16 @ Arizona State", gN: "31", scr: "W: 68-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "10", r: "6", a: "2", s: "2", b: "0", tSF: "3/10", tSP: "0.30", tPSF: "3/7", tPSP: "0.429", thPSF: "0/3", thPSP: "0.00", fTF: "4/6", turn: "2", min: "31", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame31)
        
        let CalGame30 = GameStats(label: "game", dl: "3/3/16 @ Arizona", gN: "30", scr: "L: 61-64", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "5", r: "1", a: "1", s: "0", b: "1", tSF: "2/9", tSP: "0.222", tPSF: "1/8", tPSP: "0.125", thPSF: "1/1", thPSP: "1.00", fTF: "0/0", turn: "2", min: "15", foul: "5", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame30)
        
        let CalGame29 = GameStats(label: "game", dl: "2/28/16 vs. USC", gN: "29", scr: "W: 87-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "18", r: "8", a: "2", s: "0", b: "2", tSF: "6/12", tSP: "0.50", tPSF: "3/5", tPSP: "0.60", thPSF: "3/7", thPSP: "0.429", fTF: "3/7", turn: "2", min: "32", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame29)
        
        let CalGame28 = GameStats(label: "game", dl: "2/25/16 vs. UCLA", gN: "28", scr: "W: 75-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "10", a: "3", s: "0", b: "1", tSF: "5/10", tSP: "0.50", tPSF: "3/6", tPSP: "0.50", thPSF: "2/4", thPSP: "0.50", fTF: "4/5", turn: "4", min: "33", foul: "1", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame28)
        
        let CalGame27 = GameStats(label: "game", dl: "2/21/16 @ Washington State", gN: "27", scr: "W: 80-62", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "8", r: "6", a: "1", s: "0", b: "1", tSF: "3/6", tSP: "0.50", tPSF: "2/4", tPSP: "0.50", thPSF: "1/2", thPSP: "0.50", fTF: "1/2", turn: "2", min: "27", foul: "2", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame27)
        
        let CalGame26 = GameStats(label: "game", dl: "2/18/16 @ Washington", gN: "26", scr: "W: 78-75", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "23", r: "5", a: "0", s: "2", b: "1", tSF: "7/13", tSP: "0.538", tPSF: "6/10", tPSP: "0.60", thPSF: "1/3", thPSP: "0.333", fTF: "8/10", turn: "3", min: "31", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame26)

        let CalGame25 = GameStats(label: "game", dl: "2/13/16 vs. Oregon State", gN: "25", scr: "W: 83-71", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "15", r: "7", a: "3", s: "1", b: "1", tSF: "5/11", tSP: "0.455", tPSF: "4/8", tPSP: "0.50", thPSF: "1/3", thPSP: "0.333", fTF: "4/7", turn: "4", min: "30", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "2")
        games.append(CalGame25)
        
        let CalGame24 = GameStats(label: "game", dl: "2/11/16 vs. Oregon", gN: "24", scr: "W: 83-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "4", a: "4", s: "1", b: "1", tSF: "7/16", tSP: "0.438", tPSF: "5/13", tPSP: "0.385", thPSF: "2/3", thPSP: "0.667", fTF: "0/3", turn: "1", min: "33", foul: "1", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame24)
        
        let CalGame23 = GameStats(label: "game", dl: "2/6/16 vs. Stanford", gN: "23", scr: "W: 76-61", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "3", a: "2", s: "0", b: "1", tSF: "4/12", tSP: "0.333", tPSF: "4/10", tPSP: "0.40", thPSF: "0/2", thPSP: "0.00", fTF: "8/12", turn: "2", min: "27", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame23)
        
        let CalGame22 = GameStats(label: "game", dl: "1/31/16 @ Colorado", gN: "22", scr: "L: 62-70", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "21", r: "6", a: "2", s: "0", b: "1", tSF: "6/15", tSP: "0.40", tPSF: "5/12", tPSP: "0.417", thPSF: "1/3", thPSP: "0.333", fTF: "8/11", turn: "4", min: "26", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame22)
        
        let CalGame21 = GameStats(label: "game", dl: "1/27/16 @ Utah", gN: "21", scr: "L: 64-73", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "27", r: "3", a: "2", s: "2", b: "0", tSF: "9/20", tSP: "0.450", tPSF: "8/15", tPSP: "0.533", thPSF: "1/5", thPSP: "0.20", fTF: "8/10", turn: "4", min: "33", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame21)
        
        let CalGame20 = GameStats(label: "game", dl: "1/23/16 vs. Arizona", gN: "20", scr: "W: 74-73", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "15", r: "4", a: "7", s: "1", b: "2", tSF: "4/16", tSP: "0.25", tPSF: "4/12", tPSP: "0.333", thPSF: "0/4", thPSP: "0.00", fTF: "7/11", turn: "3", min: "35", foul: "1", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame20)
        
        let CalGame19 = GameStats(label: "game", dl: "1/21/16 vs. Arizona State", gN: "19", scr: "W: 75-70", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "2", a: "2", s: "1", b: "1", tSF: "5/7", tSP: "0.714", tPSF: "4/5", tPSP: "0.80", thPSF: "1/2", thPSP: "0.50", fTF: "6/8", turn: "2", min: "20", foul: "5", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame19)
        
        let CalGame18 = GameStats(label: "game", dl: "1/14/16 @ Stanford", gN: "18", scr: "L: 71-77", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "13", r: "1", a: "2", s: "2", b: "0", tSF: "3/7", tSP: "0.429", tPSF: "2/4", tPSP: "0.50", thPSF: "1/3", thPSP: "0.333", fTF: "6/9", turn: "3", min: "22", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame18)
        
        let CalGame17 = GameStats(label: "game", dl: "1/9/16 @ Oregon State", gN: "17", scr: "L: 71-77", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "20", r: "7", a: "2", s: "0", b: "2", tSF: "8/13", tSP: "0.615", tPSF: "6/9", tPSP: "0.667", thPSF: "2/4", thPSP: "0.50", fTF: "2/8", turn: "4", min: "35", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame17)
        
        let CalGame16 = GameStats(label: "game", dl: "1/6/16 @ Oregon", gN: "16", scr: "L: 65-68", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "20", r: "9", a: "0", s: "2", b: "1", tSF: "8/10", tSP: "0.80", tPSF: "8/8", tPSP: "1.00", thPSF: "0/2", thPSP: "0.00", fTF: "4/6", turn: "4", min: "35", foul: "1", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame16)
        
        let CalGame15 = GameStats(label: "game", dl: "1/3/16 vs. Utah", gN: "15", scr: "W: 71-58", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "9", r: "7", a: "4", s: "0", b: "0", tSF: "4/11", tSP: "0.364", tPSF: "3/9", tPSP: "0.333", thPSF: "1/2", thPSP: "0.50", fTF: "0/0", turn: "4", min: "28", foul: "2", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame15)
        
        let CalGame14 = GameStats(label: "game", dl: "1/1/16 vs. Colorado", gN: "14", scr: "W: 79-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "11", a: "2", s: "0", b: "1", tSF: "6/8", tSP: "0.75", tPSF: "5/6", tPSP: "0.833", thPSF: "1/2", thPSP: "0.50", fTF: "4/4", turn: "2", min: "33", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame14)
        
        let CalGame13 = GameStats(label: "game", dl: "12/28/15 vs. Davidson", gN: "13", scr: "W: 86-60", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "7", a: "2", s: "0", b: "1", tSF: "7/8", tSP: "0.875", tPSF: "6/6", tPSP: "1.00", thPSF: "1/2", thPSP: "0.50", fTF: "2/4", turn: "6", min: "20", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame13)
        
        let CalGame12 = GameStats(label: "game", dl: "12/22/15 @ Virginia", gN: "12", scr: "L: 62-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "18", r: "6", a: "1", s: "0", b: "0", tSF: "5/11", tSP: "0.455", tPSF: "5/8", tPSP: "0.625", thPSF: "0/3", thPSP: "0.00", fTF: "8/9", turn: "4", min: "31", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame12)
        
        let CalGame11 = GameStats(label: "game", dl: "1/19/15 vs. Coppin State", gN: "11", scr: "W: 84-51", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "10", r: "6", a: "5", s: "0", b: "2", tSF: "4/10", tSP: "0.40", tPSF: "3/8", tPSP: "0.375", thPSF: "1/2", thPSP: "0.50", fTF: "1/2", turn: "4", min: "29", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame11)
        
        let CalGame10 = GameStats(label: "game", dl: "12/12/15 vs. Saint Mary's", gN: "10", scr: "W: 63-59", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "11", r: "3", a: "2", s: "1", b: "1", tSF: "3/9", tSP: "0.333", tPSF: "2/6", tPSP: "0.333", thPSF: "1/3", thPSP: "0.333", fTF: "4/8", turn: "3", min: "26", foul: "2", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame10)
        
        let CalGame9 = GameStats(label: "game", dl: "12/9/15 vs. Incarnate Word", gN: "9", scr: "W: 74-62", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "13", r: "4", a: "1", s: "1", b: "0", tSF: "5/13", tSP: "0.385", tPSF: "4/9", tPSP: "0.444", thPSF: "1/4", thPSP: "0.25", fTF: "2/4", turn: "2", min: "25", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame9)
        
        let CalGame8 = GameStats(label: "game", dl: "12/5/15 @ Wyoming", gN: "8", scr: "W: 78-72", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "9", r: "4", a: "0", s: "1", b: "0", tSF: "2/8", tSP: "0.25", tPSF: "1/6", tPSP: "0.167", thPSF: "1/2", thPSP: "0.50", fTF: "4/6", turn: "3", min: "29", foul: "5", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame8)
        
        let CalGame7 = GameStats(label: "game", dl: "1/1/15 vs. Seattle", gN: "7", scr: "W: 66-52", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "11", r: "7", a: "0", s: "1", b: "0", tSF: "3/13", tSP: "0.231", tPSF: "2/11", tPSP: "0.182", thPSF: "1/2", thPSP: "0.50", fTF: "4/6", turn: "2", min: "28", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame7)
        
        let CalGame6 = GameStats(label: "game", dl: "11/27/15 vs. Richmond", gN: "6", scr: "L: 90-94", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "27", r: "3", a: "0", s: "0", b: "0", tSF: "11/16", tSP: "0.688", tPSF: "11/13", tPSP: "0.846", thPSF: "0/3", thPSP: "0.00", fTF: "5/7", turn: "3", min: "33", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame6)
        
        let CalGame5 = GameStats(label: "game", dl: "11/26/15 @ San Diego State", gN: "5", scr: "L: 58-72", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "7", r: "3", a: "0", s: "0", b: "1", tSF: "2/8", tSP: "0.25", tPSF: "1/5", tPSP: "0.20", thPSF: "1/3", thPSP: "0.333", fTF: "2/4", turn: "3", min: "16", foul: "5", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame5)
        
        let CalGame4 = GameStats(label: "game", dl: "11/23/15 vs. Sam Houston State", gN: "4", scr: "W: 89-63", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "18", r: "11", a: "4", s: "2", b: "0", tSF: "6/10", tSP: "0.60", tPSF: "6/7", tPSP: "0.857", thPSF: "0/3", thPSP: "0.00", fTF: "6/8", turn: "1", min: "28", foul: "2", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame4)
        
        let CalGame3 = GameStats(label: "game", dl: "11/20/15 vs. East Carolina", gN: "3", scr: "W: 70-62", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "16", r: "10", a: "2", s: "0", b: "0", tSF: "4/12", tSP: "0.333", tPSF: "4/7", tPSP: "0.571", thPSF: "0/5", thPSP: "0.00", fTF: "8/14", turn: "3", min: "32", foul: "3", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame3)
        
        let CalGame2 = GameStats(label: "game", dl: "11/16/15 vs. UCSB", gN: "2", scr: "W: 85-67", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "17", r: "7", a: "0", s: "1", b: "0", tSF: "6/10", tSP: "0.60", tPSF: "5/7", tPSP: "0.714", thPSF: "1/3", thPSP: "0.333", fTF: "4/7", turn: "4", min: "21", foul: "2", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame2)
        
        let CalGame1 = GameStats(label: "game", dl: "11/13/15 vs. Rice", gN: "1", scr: "W: 97-65", bgR: 1, bgG: 0.843, bgB: 0, bgA: 1, p: "14", r: "1", a: "2", s: "0", b: "0", tSF: "5/15", tSP: "0.333", tPSF: "3/11", tPSP: "0.273", thPSF: "2/4", thPSP: "0.50", fTF: "2/2", turn: "1", min: "15", foul: "4", shotClose: "", shotMedium: "", oMid: "", sMid: "", cMid: "", oThree: "", sThree: "", cThree: "", dunks: "")
        games.append(CalGame1)
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("GameCell") as? GameCell {
            cell.accessoryView?.backgroundColor = UIColor.blackColor()
            if games[indexPath.row].label == "game" {
                let totalPoints = games[indexPath.row].totalPoints
                let totalRebounds = games[indexPath.row].totalRebounds
                let totalAssists = games[indexPath.row].totalAssists
                let totalSteals = games[indexPath.row].totalSteals
                let totalBlocks = games[indexPath.row].totalBlocks
                let totalShootingFraction = games[indexPath.row].totalShootingFraction
                
                let mainStats = totalPoints + "/" + totalRebounds + "/" + totalAssists + "/" + totalSteals + "/" + totalBlocks
                
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
                cell.configureCell(games[indexPath.row].dateLocation, gameMainStats: mainStats, gameShootingF: totalShootingFraction)
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.configureCell(games[indexPath.row].label, gameMainStats: games[indexPath.row].dateLocation, gameShootingF: "")
            }
            
            cell.backgroundColor = UIColor(red: games[indexPath.row].backgroundRed, green: games[indexPath.row].backgroundGreen, blue: games[indexPath.row].backgroundBlue, alpha: games[indexPath.row].backgroundAlpha)
            
            return cell
        } else {
            return GameCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if games[indexPath.row].label == "game" {
            self.performSegueWithIdentifier("showDetailedGame", sender: self)
        } else {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailedGame" {
            let upcoming: DetailedGameVC = segue.destinationViewController as! DetailedGameVC
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
            
            let turnovers = games[indexPath.row].turnovers
            let minutes = games[indexPath.row].minutes
            let fouls = games[indexPath.row].fouls
            let dunks = games[indexPath.row].dunks
            
            let shotClose = games[indexPath.row].shotClose
            let shotMedium = games[indexPath.row].shotMedium
            
            let openMidrange = games[indexPath.row].openMidrange
            let semiContestedMidrange = games[indexPath.row].semiContestedMidrange
            let contestedMidrange = games[indexPath.row].contestedMidrange
            let open3PT = games[indexPath.row].open3PT
            let semiContestedThree = games[indexPath.row].semiContestedThree
            let contestedThree = games[indexPath.row].contestedThree
            
            let pointsLabel = "Points: " + totalPoints
            let reboundsLabel = "Rebounds: " + totalRebounds
            let assistsLabel = "Assists: " + totalAssists
            let stealsLabel = "Steals: " + totalSteals
            let blocksLabel = "Blocks: " + totalBlocks
            
            let tSFLabel = "Total Shooting Fraction: " + totalShootingFraction
            let tSPLabel = "Total Shooting Percentage: " + totalShootingPercentage
            let twoPtSFLabel = "Two Point Shooting Fraction: " + twoPointShootingFraction
            let twoPtSPLabel = "Two Point Shooting Percentage: " + twoPointShootingPercentage
            let threePtSFLabel = "Three Point Shooting Fraction: " + threePointShootingFraction
            let threePtSPLabel = "Three Point Shooting Percentage: " + threePointShootingPercentage
            let freeThrowFLabel = "Free Throws Fraction: " + freeThrowFraction
            
            let minutesLabel = "Minutes: " + minutes
            let turnoversLabel = "Turnovers: " + turnovers
            let foulsLabel = "Fouls: " + fouls
            let dunksLabel = "Dunks: " + dunks
            
            let shotCloseLabel = "Shot Close: " + shotClose
            let shotMediumLabel = "Shot Medium: " + shotMedium
            let openMidrangeLabel = "Open Midrange: " + openMidrange
            let semiContestedMidrangeLabel = "Semi-Contested Midrange: " + semiContestedMidrange
            let contestedMidrangeLabel = "Contested Midrange: " + contestedMidrange
            let open3PTLabel = "Open Three Pointers: " + open3PT
            let semiContestedThreeLabel = "Semi-Contested Three Pointers: " + semiContestedThree
            let contestedThreeLabel = "Contested Three Pointers: " + contestedThree
            
            let titleLabel = "Game " + gameNumber + "\n" + dateLocation + "\n" + score
            let mainStatsLabel = pointsLabel + "\n\n" + reboundsLabel + "\n\n" + assistsLabel + "\n\n" + stealsLabel + "\n\n" + blocksLabel
            let additionalStatsLabel = minutesLabel + "\n\n" + turnoversLabel + "\n\n" + foulsLabel + "\n\n" + dunksLabel
            let shootingDetailsLabel = tSFLabel + "\n" + tSPLabel + "\n\n" + freeThrowFLabel + "\n\n" + twoPtSFLabel + "\n" + twoPtSPLabel + "\n\n" + threePtSFLabel + "\n" + threePtSPLabel + "\n\n" + shotCloseLabel + "\n" + shotMediumLabel + "\n\n" + openMidrangeLabel + "\n" + semiContestedMidrangeLabel + "\n" + contestedMidrangeLabel + "\n\n" + open3PTLabel + "\n" + semiContestedThreeLabel + "\n" + contestedThreeLabel
            
            upcoming.gameInfoString = titleLabel
            upcoming.mainStatsString = mainStatsLabel
            upcoming.additionalStatsString = additionalStatsLabel
            upcoming.shootingDetailsString = shootingDetailsLabel
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
}