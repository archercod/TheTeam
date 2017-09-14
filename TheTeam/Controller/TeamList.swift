//
//  ViewController.swift
//  TheTeam
//
//  Created by Marcin Pietrzak on 14.09.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class TeamList: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var teamsArray = [String]()
    
    @IBOutlet weak var teamsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }


}

