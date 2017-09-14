//
//  ViewController.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 14.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class TeamList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var teamsTableView: UITableView!
    
    var teamIDArray = [Int]()
    var teamNameArray = [String]()
    var teamLogoURLArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        
        downloadJsonFromUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadJsonFromUrl() {
        
        guard let url = URL(string: "https://spacedigital.pl/katalog/rekrutacja/formations.php") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "formations") ?? String.self)
                
                if let formationsArray = jsonObj!.value(forKey: "formations") as? NSArray {
                    for formation in formationsArray {
                        if let formationDict = formation as? NSDictionary {
                            
                            if let teamID = formationDict.value(forKey: "team_id") {
                                self.teamIDArray.append(teamID as! Int)
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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamsTableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamListCell
        
        cell?.teamName.text = teamNameArray[indexPath.row]
        
        let imageURL = NSURL(string: "http://\(teamLogoURLArray[indexPath.row])")
        
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as? URL)!)
            cell?.teamLogo.image = UIImage(data: data as! Data)
        }
        
        return cell!

    }
    
   
   


}

