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
        
        loadJSON()
        
        self.teamNameLabel.text = teamName
        
        let imageURL = NSURL(string: "http://\(String(teamLogo!)!)")
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as URL?)!)
            teamLogoImage.image = UIImage(data: data! as Data)
        }
        
        for button in playerButtonWithImage {
            button.layer.cornerRadius = 20
        }
    }
    
    func playerImageFromUrl(string: String, tag: Int) {
        let imageURL = NSURL(string: "http://\(string)" as String)
        
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as URL!)!)
            playerButtonWithImage[tag].setImage(UIImage(data: data! as Data)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    
    func loadJSON(){
        
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
                            let playerPhoto = playersPhotos as! String
                            let playerName = playersNames as! String
                            let playerAge = playersAge as? Int
                            let playerCountry = playersCountry as! String
                            let playerPosition = playersPosition as! String
                            
                            
                            switch playerLineupPosition {
                            case 11:
                                playerImageFromUrl(string: playerPhoto, tag: 0)
                            case 21...29:
                                playerImageFromUrl(string: playerPhoto, tag: 1)
                            case 31...39:
                                playerImageFromUrl(string: playerPhoto, tag: 2)
                            case 41...49:
                                playerImageFromUrl(string: playerPhoto, tag: 3)
                            case 51...59:
                                 playerImageFromUrl(string: playerPhoto, tag: 4)
                            case 61...69:
                                 playerImageFromUrl(string: playerPhoto, tag: 5)
                            case 71...79:
                                playerImageFromUrl(string: playerPhoto, tag: 6)
                            case 81...89:
                                playerImageFromUrl(string: playerPhoto, tag: 7)
                            case 91...99:
                                playerImageFromUrl(string: playerPhoto, tag: 8)
                            case 101...109:
                                playerImageFromUrl(string: playerPhoto, tag: 9)
                            case 111...119:
                                 playerImageFromUrl(string: playerPhoto, tag: 10)
                            default:
                                print("Error")
                            }
                        }
                    }
                }
            }
            
        } catch {
            print("Error")
        }
    }
    
    
    
}
