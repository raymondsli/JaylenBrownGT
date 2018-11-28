//
//  FirstViewController.swift
//  JB
//
//  Created by Raymond Li on 8/17/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController, NSURLConnectionDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var headerView: PlayerOverviewHead!
    @IBOutlet weak var personalView: PlayerPersonal!
    var currentSeason: String = ""
    var currentYear: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let curYear = calendar.component(.year, from: currentDate)
        let curMonth = calendar.component(.month, from: currentDate)
        
        currentYear = String(curYear)
        
        if curMonth >= 10 {
            currentSeason = String(curYear) + "-" + String(curYear - 2000 + 1)
        } else {
            currentSeason = String(curYear - 1) + "-" + String(curYear - 2000)
        }
        
        getNextGameJSON()
    }
    
    func getNextGameJSON() {
        let urlString = "http://data.nba.net/data/10s/prod/v1/" + currentYear + "/teams/celtics/schedule.json"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    let league = json["league"] as! [String: Any]
                    let games: NSArray = league["standard"] as! NSArray
                    
                    let nextGameOptional = self.findNextGame(games: games)
                        
                    guard let nextGame = nextGameOptional else {
                        return
                    }
                    
                    let startTime = nextGame["startTimeUTC"] as! String
                    let startDate = nextGame["startDateEastern"] as! String
                    let isHomeTeam = nextGame["isHomeTeam"] as! Bool
                    
                    var nextGameOpponent = ""
                    var homeOAway = ""
                    
                    if isHomeTeam {
                        let vTeam = nextGame["vTeam"] as! [String: String]
                        let oppo = vTeam["teamId"]
                        nextGameOpponent = self.getTeamFromId(teamId: oppo!)
                        homeOAway = "vs. "
                    } else {
                        let hTeam = nextGame["hTeam"] as! [String: String]
                        let oppo = hTeam["teamId"]
                        nextGameOpponent = self.getTeamFromId(teamId: oppo!)
                        homeOAway = "@"
                    }
                    
                    let nextGameDate = self.formatDate(date: startDate)
                    let nextGameTime = self.formatTime(time: startTime)
                    let nextGameDetails = homeOAway + nextGameOpponent + " - " + nextGameTime
                    
                    DispatchQueue.main.async(execute: {
                        self.headerView.nextGameDate.text = "Next Game: " + nextGameDate
                        self.headerView.nextGameDetails.text = nextGameDetails
                    })
                } catch {
                    print("Could not serialize")
                }
            }
        }).resume()
    }
    
    func findNextGame(games: NSArray) -> [String: Any]? {
        
        for i in 0..<games.count {
            let currentGame = games[i] as! [String: Any]
            let statusNum = currentGame["statusNum"] as! Int
            if statusNum == 1 || statusNum == 2 {
                return currentGame
            }
        }
        return nil
    }
    
    
    func formatDate(date: String) -> String {
        let monthStartIndex = date.index(date.startIndex, offsetBy: 4)
        let dayStartIndex = date.index(date.startIndex, offsetBy: 6)
        
        let monthRange = monthStartIndex..<dayStartIndex
        
        let month = date[monthRange]
        let day = date.suffix(from: dayStartIndex)
        
        return month + "/" + day
    }
    
    func formatTime(time: String) -> String {
        let hourStartIndex = time.index(time.startIndex, offsetBy: 11)
        let hourEndIndex = time.index(time.startIndex, offsetBy: 13)
        
        let minuteStartIndex = time.index(time.startIndex, offsetBy: 14)
        let minuteEndIndex = time.index(time.startIndex, offsetBy: 16)
        
        let hourRange = hourStartIndex..<hourEndIndex
        let minuteRange = minuteStartIndex..<minuteEndIndex
        
        let utcHour = time[hourRange]
        let minuteString = time[minuteRange]
        
        guard let intHour = Int(utcHour) else {
            return "00:00"
        }
        
        var hourString = "00"
        var timeHalf = "PM"
        
        if intHour <= 6 {
            hourString = String(5 + intHour)
            timeHalf = "PM"
        } else if 7 <= intHour && intHour <= 18 {
            hourString = String(intHour - 7)
            timeHalf = "AM"
        } else if intHour == 19 {
            hourString = String(12)
            timeHalf = "PM"
        } else if 20 <= intHour && intHour <= 23 {
            hourString = String(intHour - 19)
            timeHalf = "PM"
        }
        
        return hourString + ":" + minuteString + " " + timeHalf + " PST"
    }

    
    
    func getTeamFromId(teamId: String) -> String {
        switch teamId {
        case "1610612737":
            return "ATL"
        case "1610612751":
            return "BKN"
        case "1610612738":
            return "BOS"
        case "1610612766":
            return "CHA"
        case "1610612741":
            return "CHI"
        case "1610612739":
            return "CLE"
        case "1610612742":
            return "DAL"
        case "1610612743":
            return "DEN"
        case "1610612765":
            return "DET"
        case "1610612744":
            return "GSW"
        case "1610612745":
            return "HOU"
        case "1610612754":
            return "IND"
        case "1610612746":
            return "LAC"
        case "1610612747":
            return "LAL"
        case "1610612763":
            return "MEM"
        case "1610612748":
            return "MIA"
        case "1610612749":
            return "MIL"
        case "1610612750":
            return "MIN"
        case "1610612740":
            return "NOP"
        case "1610612752":
            return "NYK"
        case "1610612760":
            return "OKC"
        case "1610612753":
            return "ORL"
        case "1610612755":
            return "PHI"
        case "1610612756":
            return "PHX"
        case "1610612757":
            return "POR"
        case "1610612758":
            return "SAC"
        case "1610612759":
            return "SAS"
        case "1610612761":
            return "TOR"
        case "1610612762":
            return "UTA"
        case "1610612764":
            return "WAS"
        default:
            return ""
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["raymond.s.li@berkeley.edu"])
        mailComposerVC.setSubject("App Feedback")
        mailComposerVC.setMessageBody("Suggestions, bugs, or general feedback.", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send email. Please check email configuration and try again.", preferredStyle: .alert)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if (MFMailComposeViewController.canSendMail()) {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


