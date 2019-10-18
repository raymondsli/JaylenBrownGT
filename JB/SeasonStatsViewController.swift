//
//  SeasonStatsViewController.swift
//  JB
//
//  Created by Raymond Li on 8/19/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit

class SeasonStatsViewController: UIViewController, NSURLConnectionDelegate {
    
    @IBOutlet weak var baseView: BaseStatView!
    @IBOutlet weak var advancedView: AdvancedStatView!
    
    
    var baseStat: BaseStat = BaseStat()
    var advancedStat: AdvancedStat = AdvancedStat()
    var currentSeason: String = ""
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = UIApplication.shared.keyWindow!
        var navBarHeight: CGFloat = 40
        var tabBarHeight: CGFloat = 49
        if #available(iOS 11.0, *) {
            navBarHeight += window.safeAreaInsets.top
            tabBarHeight += window.safeAreaInsets.bottom
        }
        loadingView = UIView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y + navBarHeight, width: window.frame.width, height: window.frame.height - navBarHeight - tabBarHeight))
        loadingView.backgroundColor = .white
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        loadingView.addSubview(activityIndicator)
        window.addSubview(loadingView)
        
        activityIndicator.startAnimating()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let curYear = calendar.component(.year, from: currentDate)
        let curMonth = calendar.component(.month, from: currentDate)
        
        if curMonth >= 10 {
            currentSeason = String(curYear) + "-" + String(curYear - 2000 + 1)
        } else {
            currentSeason = String(curYear - 1) + "-" + String(curYear - 2000)
        }
        
        getSeasonJSON(type: "Base")
        getSeasonJSON(type: "Advanced")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
    func getSeasonJSON(type: String) {
        let urlString = "https://stats.nba.com/stats/playerdashboardbyyearoveryear?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlusMinus=N&Rank=N&Season=" + currentSeason + "&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&Split=yoy&VsConference=&VsDivision=&MeasureType=" + type + "&PlayerID=1627759"
        let url = URL(string: urlString)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        sessionConfig.timeoutIntervalForResource = 30
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: url!, completionHandler: {(data, response, error) in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    let resultSetsTemp: NSArray = json["resultSets"] as! NSArray
                    let resultSets = resultSetsTemp[1] as! [String: Any]
                    let rowSetTemp: NSArray = resultSets["rowSet"] as! NSArray
                    let season: NSArray = rowSetTemp[0] as! NSArray
                    
                    if season[1] as! String != "2018-19" {
                        DispatchQueue.main.async(execute: {
                            self.setToNA(type: type)
                            self.activityIndicator.stopAnimating()
                            self.loadingView.removeFromSuperview()
                        })
                        return
                    }
                    
                    if type == "Base" {
                        self.turnRowSetIntoBaseStat(rowSet: season)
                    } else if type == "Advanced" {
                        self.turnRowSetIntoAdvancedStat(rowSet: season)
                    }
                    
                    DispatchQueue.main.async(execute: {
                        self.baseView.row1.stat1.text = "GP"
                        self.baseView.row1.stat2.text = "MIN"
                        self.baseView.row1.stat3.text = "PTS"
                        self.baseView.row1.stat4.text = "REB"
                        self.baseView.row1.amount1.text = self.baseStat.GP
                        self.baseView.row1.amount2.text = self.baseStat.MIN
                        self.baseView.row1.amount3.text = self.baseStat.PTS
                        self.baseView.row1.amount4.text = self.baseStat.TREB
                        
                        self.baseView.row2.stat1.text = "OREB"
                        self.baseView.row2.stat2.text = "DREB"
                        self.baseView.row2.stat3.text = "FG%"
                        self.baseView.row2.stat4.text = "FGM | FGA"
                        self.baseView.row2.amount1.text = self.baseStat.OREB
                        self.baseView.row2.amount2.text = self.baseStat.DREB
                        self.baseView.row2.amount3.text = self.baseStat.FGP + "%"
                        self.baseView.row2.amount4.text = self.baseStat.FGM + " | " + self.baseStat.FGA
                        
                        self.baseView.row3.stat1.text = "AST"
                        self.baseView.row3.stat2.text = "STL"
                        self.baseView.row3.stat3.text = "3P%"
                        self.baseView.row3.stat4.text = "3PM | 3PA"
                        self.baseView.row3.amount1.text = self.baseStat.AST
                        self.baseView.row3.amount2.text = self.baseStat.STL
                        self.baseView.row3.amount3.text = self.baseStat.FG3P + "%"
                        self.baseView.row3.amount4.text = self.baseStat.FG3M + " | " + self.baseStat.FG3A
                        
                        self.baseView.row4.stat1.text = "BLK"
                        self.baseView.row4.stat2.text = "TOV"
                        self.baseView.row4.stat3.text = "FT%"
                        self.baseView.row4.stat4.text = "FTM | FTA"
                        self.baseView.row4.amount1.text = self.baseStat.BLK
                        self.baseView.row4.amount2.text = self.baseStat.TOV
                        self.baseView.row4.amount3.text = self.baseStat.FTP + "%"
                        self.baseView.row4.amount4.text = self.baseStat.FTM + " | " + self.baseStat.FTA
                        
                        self.advancedView.row1.stat1.text = "TPACE"
                        self.advancedView.row1.stat2.text = "USG"
                        self.advancedView.row1.stat3.text = "OREB%"
                        self.advancedView.row1.stat4.text = "OFFRAT"
                        self.advancedView.row1.amount1.text = self.advancedStat.PACE
                        self.advancedView.row1.amount2.text = self.advancedStat.USG + "%"
                        self.advancedView.row1.amount3.text = self.advancedStat.OREBP + "%"
                        self.advancedView.row1.amount4.text = self.advancedStat.ORAT
                        
                        self.advancedView.row2.stat1.text = "EFG"
                        self.advancedView.row2.stat2.text = "TS%"
                        self.advancedView.row2.stat3.text = "DREB%"
                        self.advancedView.row2.stat4.text = "DRAT"
                        self.advancedView.row2.amount1.text = self.advancedStat.EFG + "%"
                        self.advancedView.row2.amount2.text = self.advancedStat.TSP + "%"
                        self.advancedView.row2.amount3.text = self.advancedStat.DREBP + "%"
                        self.advancedView.row2.amount4.text = self.advancedStat.DRAT
                        
                        self.advancedView.row3.stat1.text = "AST/TO"
                        self.advancedView.row3.stat2.text = "AST%"
                        self.advancedView.row3.stat3.text = "REB%"
                        self.advancedView.row3.stat4.text = "NETRAT"
                        self.advancedView.row3.amount1.text = self.advancedStat.A2T
                        self.advancedView.row3.amount2.text = self.advancedStat.ASTP + "%"
                        self.advancedView.row3.amount3.text = self.advancedStat.REBP + "%"
                        self.advancedView.row3.amount4.text = self.advancedStat.NRAT
                        
                        self.activityIndicator.stopAnimating()
                        self.loadingView.removeFromSuperview()
                    })
                } catch {
                    print("Could not serialize")
                }
            }
        }).resume()
    }
    
    func turnRowSetIntoBaseStat(rowSet: NSArray) {
        let year = rowSet[1] as! String
        let team = rowSet[3] as! String
        
        let GP = String(rowSet[5] as! Int)
        let MIN = convertToString(val: rowSet[9] as! Double)
        let PF = convertToString(val: rowSet[27] as! Double)
        
        let FGM = convertToString(val: rowSet[10] as! Double)
        let FGA = convertToString(val: rowSet[11] as! Double)
        let FGP = convertToString(val: rowSet[12] as! Double * 100)
        
        let FG3M = convertToString(val: rowSet[13] as! Double)
        let FG3A = convertToString(val: rowSet[14] as! Double)
        let FG3P = convertToString(val: rowSet[15] as! Double * 100)
        
        let FTM = convertToString(val: rowSet[16] as! Double)
        let FTA = convertToString(val: rowSet[17] as! Double)
        let FTP = convertToString(val: rowSet[18] as! Double * 100)
        
        let OREB = convertToString(val: rowSet[19] as! Double)
        let DREB = convertToString(val: rowSet[20] as! Double)
        let TREB = convertToString(val: rowSet[21] as! Double)
        
        let PTS = convertToString(val: rowSet[29] as! Double)
        let AST = convertToString(val: rowSet[22] as! Double)
        let STL = convertToString(val: rowSet[24] as! Double)
        let BLK = convertToString(val: rowSet[25] as! Double)
        let TOV = convertToString(val: rowSet[23] as! Double)
        
        self.baseStat = BaseStat(year: year, team: team, GP: GP, MIN: MIN, PF: PF, FGM: FGM, FGA: FGA, FGP: FGP, FG3M: FG3M, FG3A: FG3A, FG3P: FG3P, FTM: FTM, FTA: FTA, FTP: FTP, OREB: OREB, DREB: DREB, TREB: TREB, PTS: PTS, AST: AST, STL: STL, BLK: BLK, TOV: TOV)
    }
    
    func turnRowSetIntoAdvancedStat(rowSet: NSArray) {
        let ORAT = convertToString(val: rowSet[11] as! Double)
        let DRAT = convertToString(val: rowSet[14] as! Double)
        let NRAT = convertToString(val: rowSet[17] as! Double)
        let USG = convertToString(val: rowSet[28] as! Double * 100)
        let EFG = convertToString(val: rowSet[26] as! Double * 100)
        let TSP = convertToString(val: rowSet[27] as! Double * 100)
        let ASTP = convertToString(val: rowSet[19] as! Double * 100)
        let A2T = convertToString(val: rowSet[20] as! Double)
        let REBP = convertToString(val: rowSet[24] as! Double * 100)
        let OREBP = convertToString(val: rowSet[22] as! Double * 100)
        let DREBP = convertToString(val: rowSet[23] as! Double * 100)
        let PACE = convertToString(val: rowSet[30] as! Double)
        
        self.advancedStat = AdvancedStat(ORAT: ORAT, DRAT: DRAT, NRAT: NRAT, USG: USG, EFG: EFG, TSP: TSP, ASTP: ASTP, A2T: A2T, REBP: REBP, OREBP: OREBP, DREBP: DREBP, PACE: PACE)
    }
    
    func convertToString(val: Double) -> String {
        let valString = String(val)
        let valArr = valString.components(separatedBy: ".")
        
        guard valArr.count == 2 else {
            return ""
        }
        
        var wholeNumberString = valArr[0]
        var decimalString = String(valArr[1].prefix(3))
        
        if decimalString.count == 3 {
            let lastString = decimalString.last
            let lastInt = Int(String(lastString!))
            
            guard lastInt != nil else {
                return ""
            }
            
            decimalString = String(decimalString.dropLast())
            
            if lastInt! >= 5 {
                let secondLastString = decimalString.last
                var secondLastInt = Int(String(secondLastString!))
                
                if secondLastInt == 9 {
                    secondLastInt = 0
                    var firstLastInt = Int(decimalString.prefix(1))
                    
                    if firstLastInt == 9 {
                        firstLastInt = 0
                        wholeNumberString = String(Int(wholeNumberString)! + 1)
                    } else {
                        firstLastInt = firstLastInt! + 1
                    }
                    
                    decimalString = String(firstLastInt!) + String(secondLastInt!)
                } else {
                    secondLastInt = secondLastInt! + 1
                    decimalString = decimalString.prefix(1) + String(secondLastInt!)
                }
            }
        }
        
        decimalString = removeTrailingZeroes(dec: decimalString)
        
        if decimalString == "" {
            return wholeNumberString
        }
        
        return wholeNumberString + "." + decimalString
    }
    
    
    
    func removeTrailingZeroes(dec: String) -> String {
        var decString = dec
        while decString.last == "0" {
            decString = String(decString.dropLast())
        }
        
        return decString
    }
    
    func setToNA(type: String) {
        if type == "Base" {
            self.baseView.row1.stat1.text = "GP"
            self.baseView.row1.stat2.text = "MIN"
            self.baseView.row1.stat3.text = "PTS"
            self.baseView.row1.stat4.text = "REB"
            self.baseView.row1.amount1.text = "NA"
            self.baseView.row1.amount2.text = "NA"
            self.baseView.row1.amount3.text = "NA"
            self.baseView.row1.amount4.text = "NA"
            
            self.baseView.row2.stat1.text = "OREB"
            self.baseView.row2.stat2.text = "DREB"
            self.baseView.row2.stat3.text = "FG%"
            self.baseView.row2.stat4.text = "FGM | FGA"
            self.baseView.row2.amount1.text = "NA"
            self.baseView.row2.amount2.text = "NA"
            self.baseView.row2.amount3.text = "NA"
            self.baseView.row2.amount4.text = "NA | NA"
            
            self.baseView.row3.stat1.text = "AST"
            self.baseView.row3.stat2.text = "STL"
            self.baseView.row3.stat3.text = "3P%"
            self.baseView.row3.stat4.text = "3PM | 3PA"
            self.baseView.row3.amount1.text = "NA"
            self.baseView.row3.amount2.text = "NA"
            self.baseView.row3.amount3.text = "NA"
            self.baseView.row3.amount4.text = "NA | NA"
            
            self.baseView.row4.stat1.text = "BLK"
            self.baseView.row4.stat2.text = "TOV"
            self.baseView.row4.stat3.text = "FT%"
            self.baseView.row4.stat4.text = "FTM | FTA"
            self.baseView.row4.amount1.text = "NA"
            self.baseView.row4.amount2.text = "NA"
            self.baseView.row4.amount3.text = "NA"
            self.baseView.row4.amount4.text = "NA | NA"
        } else if type == "Advanced" {
            self.advancedView.row1.stat1.text = "TPACE"
            self.advancedView.row1.stat2.text = "USG"
            self.advancedView.row1.stat3.text = "OREB%"
            self.advancedView.row1.stat4.text = "OFFRAT"
            self.advancedView.row1.amount1.text = "NA"
            self.advancedView.row1.amount2.text = "NA"
            self.advancedView.row1.amount3.text = "NA"
            self.advancedView.row1.amount4.text = "NA"
            
            self.advancedView.row2.stat1.text = "EFG"
            self.advancedView.row2.stat2.text = "TS%"
            self.advancedView.row2.stat3.text = "DREB%"
            self.advancedView.row2.stat4.text = "DRAT"
            self.advancedView.row2.amount1.text = "NA"
            self.advancedView.row2.amount2.text = "NA"
            self.advancedView.row2.amount3.text = "NA"
            self.advancedView.row2.amount4.text = "NA"
            
            self.advancedView.row3.stat1.text = "AST/TO"
            self.advancedView.row3.stat2.text = "AST%"
            self.advancedView.row3.stat3.text = "REB%"
            self.advancedView.row3.stat4.text = "NETRAT"
            self.advancedView.row3.amount1.text = "NA"
            self.advancedView.row3.amount2.text = "NA"
            self.advancedView.row3.amount3.text = "NA"
            self.advancedView.row3.amount4.text = "NA"
        }
    }
}

struct BaseStat {
    var year: String = ""
    var team: String = ""
    var GP: String = ""
    
    var MIN: String = ""
    var PF: String = "" //Not used
    
    var FGM: String = ""
    var FGA: String = ""
    var FGP: String = ""
    
    var FG3M: String = ""
    var FG3A: String = ""
    var FG3P: String = ""
    
    var FTM: String = ""
    var FTA: String = ""
    var FTP: String = ""
    
    var OREB: String = ""
    var DREB: String = ""
    var TREB: String = ""
    
    var PTS: String = ""
    var AST: String = ""
    var STL: String = ""
    var BLK: String = ""
    var TOV: String = ""
    
    init(year: String, team: String, GP: String, MIN: String, PF: String, FGM: String, FGA: String, FGP: String, FG3M: String, FG3A: String, FG3P: String, FTM: String, FTA: String, FTP: String, OREB: String, DREB: String, TREB: String, PTS: String, AST: String, STL: String, BLK: String, TOV: String) {
        self.year = year
        self.team = team
        self.GP = GP
        self.MIN = MIN
        self.PF = PF
        self.FGM = FGM
        self.FGA = FGA
        self.FGP = FGP
        self.FG3M = FG3M
        self.FG3A = FG3A
        self.FG3P = FG3P
        self.FTM = FTM
        self.FTA = FTA
        self.FTP = FTP
        self.OREB = OREB
        self.DREB = DREB
        self.TREB = TREB
        self.PTS = PTS
        self.AST = AST
        self.STL = STL
        self.BLK = BLK
        self.TOV = TOV
    }
    
    init() {}
}

struct AdvancedStat {
    var ORAT: String = ""
    var DRAT: String = ""
    var NRAT: String = ""
    var USG: String = ""
    var EFG: String = ""
    var TSP: String = ""
    var ASTP: String = ""
    var A2T: String = ""
    var REBP: String = ""
    var OREBP: String = ""
    var DREBP: String = ""
    var PACE: String = ""
    
    init(ORAT: String, DRAT: String, NRAT: String, USG: String, EFG: String, TSP: String, ASTP: String, A2T: String, REBP: String, OREBP: String, DREBP: String, PACE: String) {
        self.ORAT = ORAT
        self.DRAT = DRAT
        self.NRAT = NRAT
        self.USG = USG
        self.EFG = EFG
        self.TSP = TSP
        self.ASTP = ASTP
        self.A2T = A2T
        self.REBP = REBP
        self.OREBP = OREBP
        self.DREBP = DREBP
        self.PACE = PACE
    }
    
    init() {}
}
