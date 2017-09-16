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
    
    var teamIDArray = [String]()
    var teamNameArray = [String]()
    var teamLogoURLArray = [String]()
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
        return teamNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamsTableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamListCell
        
        cell?.teamName.text = teamNameArray[indexPath.row]
        cell?.backgroundImage.image = UIImage(named: stadiumPhotoArray[indexPath.row])
        
        let imageURL = NSURL(string: "http://\(teamLogoURLArray[indexPath.row])")
        
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
                let teamName = teamNameArray[indexpath.row] as String
                DVC.teamName = teamName
                
                let teamLogo = teamLogoURLArray[indexpath.row] as String
                DVC.teamLogo = teamLogo
                
                let teamID = teamIDArray[indexpath.row] as String
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
                            
                            if let teamID = formationDict.value(forKey: "team_id") {
                                self.teamIDArray.append(String(teamID as! Int))
                                print(teamID)
                            }
                            if let teamLogo = formationDict.value(forKey: "team_logo") {
                                self.teamLogoURLArray.append(teamLogo as! String)
                            }
                            if let teamName = formationDict.value(forKey: "team_name") {
                                self.teamNameArray.append(teamName as! String)
                            }
                            
                            OperationQueue.main.addOperation({
                                self.teamsTableView.reloadData()
                            })
                        }
                    }
                }
            }
            }.resume()
        
        print(teamIDArray)
        
        }


}
