//
//  ViewController.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 14.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class TeamList: UIViewController {
    
    @IBOutlet weak var teamsTableView: UITableView!
    
    var teamArray = [Teams]()
    var stadiumPhotoArray = ["piastCourt.jpg", "lechiaCourt.jpg", "termalicaCourt.jpg", "gornikCourt.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadJSON()
    }

}

extension TeamList: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamsTableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamListCell
        
        let teams = teamArray[indexPath.row]
        
        cell?.teamName.text = teams.teamName
        cell?.backgroundImage.image = UIImage(named: stadiumPhotoArray[indexPath.row])
        
        let imageURL = NSURL(string: "http://\(teams.teamLogo)")
        
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as URL?)!)
            cell?.teamLogo.image = UIImage(data: data! as Data)
        }
        
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "teamPlayers") {
            
            let DVC = segue.destination as! TeamOnCourt
            
            if let indexpath = self.teamsTableView.indexPathForSelectedRow {
                
                let teams = teamArray[indexpath.row]
                
                let teamName = teams.teamName as String
                DVC.teamName = teamName
                
                let teamLogo = teams.teamLogo as String
                DVC.teamLogo = teamLogo
                
                let teamID = teams.teamID as Int
                DVC.teamID = teamID
            }
        }    }
}

private extension TeamList {
    
    func loadJSON() {
        
        guard let url = URL(string: "https://spacedigital.pl/katalog/rekrutacja/formations.php") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "formations") ?? String.self)
                
                if let formationsArray = jsonObj!.value(forKey: "formations") as? NSArray {
                    for formation in formationsArray {
                        if let formationDict = formation as? NSDictionary {
                            
                            let teamIDStr: Int = {
                                if let teamID = formationDict.value(forKey: "team_id") {
                                    return teamID as! Int
                                }
                                return 0
                            }()
                            
                            let teamLogoStr: String = {
                                if let teamLogo = formationDict.value(forKey: "team_logo") {
                                    return teamLogo as! String
                                }
                                return "No Data"
                            }()
                            
                            let teamNameStr: String = {
                                if let teamName = formationDict.value(forKey: "team_name") {
                                    return teamName as! String
                                }
                                return "No Data"
                            }()
                            
                            self.teamArray.append(Teams(teamID: teamIDStr, teamLogo: teamLogoStr, teamName: teamNameStr))
                           
                            
                            OperationQueue.main.addOperation({
                                self.teamsTableView.reloadData()
                            })
                        }
                    }
                }
            }
            }.resume()
        
        }


}
