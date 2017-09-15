//
//  TeamOnCourt.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 14.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class TeamOnCourt: UIViewController {
    
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet var playerButtonWithImage: [UIButton]!
    
    var teamLogo: String?
    var teamName: String?
    var teamID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonFromUrl()
        
        print(teamID!)

        self.teamNameLabel.text = teamName
        
        let imageURL = NSURL(string: "http://\(String(teamLogo!)!)")
        
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as URL?)!)
            teamLogoImage.image = UIImage(data: data! as Data)
        }
        
    }
    
    func playerImageFromUrl(string: String, tag: Int) {
        let imageURL = NSURL(string: "http://\(string)" as String)
        
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as URL!)!)
            playerButtonWithImage[tag].setImage(UIImage(data: data! as Data), for: .normal)
        }

    }
    
    
    func getJsonFromUrl(){
        
        guard let path = Bundle.main.path(forResource: "team\(teamID!)", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            
            print(json!.value(forKey: "players") ?? String.self)
            
            if let playersArray = json!.value(forKey: "players") as? NSArray {
                for player in playersArray {
                    if let playersDict = player as? NSDictionary {
                        
                        if let playersLineupPositions = playersDict.value(forKey: "lineup_position"),
                            let playersPhotos = playersDict.value(forKey: "photo_url"),
                            let playersNames = playersDict.value(forKey: "name"),
                            let playersAge = playersDict.value(forKey: "age"),
                            let playersCountry = playersDict.value(forKey: "country"),
                            let playersPosition = playersDict.value(forKey: "position") {
                            
                                let playerLineupPosition = playersLineupPositions as! Int
                                print(playerLineupPosition)
                            
                                let playerPhoto = playersPhotos as! String
                                print(playerPhoto)
                            
                                let playerName = playersNames as! String
                                print(playerName)
                            
                                let playerAge = playersAge as! Int
                                print(playerAge)
                            
                                let playerCountry = playersCountry as! String
                                print(playerCountry)
                            
                                let playerPosition = playersPosition as! String
                                print(playerPosition)
                            
                            if playerLineupPosition == 11 {
                                playerImageFromUrl(string: playerPhoto, tag: 0)
                                playerButtonWithImage[0].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 21 && playerLineupPosition <= 29  {
                                playerImageFromUrl(string: playerPhoto, tag: 1)
                                playerButtonWithImage[1].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 31 && playerLineupPosition <= 39  {
                                playerImageFromUrl(string: playerPhoto, tag: 2)
                                playerButtonWithImage[2].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 41 && playerLineupPosition <= 49 {
                                playerImageFromUrl(string: playerPhoto, tag: 3)
                                playerButtonWithImage[3].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 51 && playerLineupPosition <= 59 {
                                playerImageFromUrl(string: playerPhoto, tag: 4)
                                playerButtonWithImage[4].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 61 && playerLineupPosition <= 69 {
                                playerImageFromUrl(string: playerPhoto, tag: 5)
                                playerButtonWithImage[5].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 71 && playerLineupPosition <= 79 {
                                playerImageFromUrl(string: playerPhoto, tag: 6)
                                playerButtonWithImage[6].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 81 && playerLineupPosition <= 89 {
                                playerImageFromUrl(string: playerPhoto, tag: 7)
                                playerButtonWithImage[7].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 91 && playerLineupPosition <= 99 {
                                playerImageFromUrl(string: playerPhoto, tag: 8)
                                playerButtonWithImage[8].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 101 && playerLineupPosition <= 109 {
                                    playerImageFromUrl(string: playerPhoto, tag: 9)
                                playerButtonWithImage[9].setTitle(playerName, for: .normal)
                            } else if playerLineupPosition >= 111 && playerLineupPosition <= 119 {
                                playerImageFromUrl(string: playerPhoto, tag: 10)
                                playerButtonWithImage[10].setTitle(playerName, for: .normal)
                            }
                        }
                    }
                }
            }
            
        } catch {
            print("error")
        }
    }


    
}
