//
//  StationsViewController.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import Foundation
import UIKit

class StationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stationsList : [String]?
    
    @IBOutlet weak var stationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let metroStations = MetroStations()
        stationsList = metroStations.getWorkingStationListToDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false;
        self.title = "Stations"
        
        if let selectionIndexPath = stationsTableView.indexPathForSelectedRow {
            stationsTableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsList!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as! StationTableViewCell
        cell.stationName.text = stationsList![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let stationDetainsVC = storyBoard.instantiateViewController(withIdentifier: "StationDetailsViewController")
            as! StationDetailsViewController
        
        stationDetainsVC.stationName = stationsList![indexPath.row]

        self.navigationController?.pushViewController(stationDetainsVC, animated: true)
        self.title = nil

        self.tabBarController?.tabBar.isHidden = true;
    }
    
}

class StationTableViewCell : UITableViewCell {
    @IBOutlet weak var stationName: UILabel!
}
