//
//  AchievementsTableView.swift
//  JB
//
//  Created by Raymond Li on 7/30/17.
//  Copyright © 2017 Raymond Li. All rights reserved.
//

import UIKit

class AchievementsTable: UITableViewController {
    var achievements = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAchievements()
    }
    
    func addAchievements() {
        let header = "Achievements"
        achievements.append(header)
        
        let personal_info = "Full Name: Jaylen Brown\nBirthday: October 24, 1996 (Age 20)\nBirthplace: Marietta, Georgia\nHometown: Alpharetta, Georgia\nHeight: 6'7''\nWeight225\nWingspan: 6'11.75''\n2016 Draft: 3rd Overall Pick\nJersey Number: 7\nExperience: 1 Year"
        achievements.append(personal_info)
        
        let NBA_A = "NBA Achievements: Boston Celtics\n\n2017 NBA All-Rookie Second Team"
        achievements.append(NBA_A)
        
        let college_A = "College Achievements: California\n\nFirst Team All-Pac-12\nPac-12 Freshman of the Year\nPac-12 All Freshman Team\nUSBWA Freshman All-American Team"
        achievements.append(college_A)
        
        let HS_A = "High School Achievements: Wheeler HS\n\nSenior Year Led Wheeler to Georgia 6A State Title\nConsensus first-team All-American\n2015 McDonald's All American\nGatorade Georgia Boys' Player of the Year\nMr. Georgia Basketball\n2014 FIBA Americas Gold Medalist As Member of the 2014 USA U18 National Team\nESPN Ranked #4 Overall Player\nScount Ranked #4 Overall Player\n247Sports Ranked #4 Overall Player\nRivals Ranked #3 Overall Player"
        achievements.append(HS_A)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementsCell", for: indexPath)

        cell.textLabel?.text = achievements[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
            return 100.0
        } else if indexPath.row == 1 {
            return 200.0
        } else if indexPath.row == 2 {
            return 200.0
        } else if indexPath.row == 3 {
            return 250.0
        } else {
            return 300.0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //We are using a one column table.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows is the length of the seasons array.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
