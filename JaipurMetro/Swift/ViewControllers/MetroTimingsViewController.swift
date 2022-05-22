//
//  MetroTimingsViewController.swift
//  JaipurMetro
//
//  Created by mahi 
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit

class MetroTimingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stationName : String?
    var metroTimings : MetroTimingsModel?
    
    var selectedTab = ""
    
    let FIRST_TAB = "firsttab"
    let SECOND_TAB = "secondtab"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = stationName! + " Metro Timetable"
        
        if Utils.STATION_MANSAROVAR.compare(stationName!) == ComparisonResult.orderedSame {
            secondTabLabel.text = Utils.ENDS_HERE
        } else if Utils.STATION_CHANDPOLE.compare(stationName!) == ComparisonResult.orderedSame {
            firstTabLabel.text = Utils.ENDS_HERE
        }
        
        selectedTab = FIRST_TAB
        
        let firstTabLabelTap = UITapGestureRecognizer(target: self, action : #selector(OnTabSelected(sender:)))
        firstTabLabelTap.name = FIRST_TAB
        firstTabLabel.addGestureRecognizer(firstTabLabelTap)
        
        let secondTabLabelTap = UITapGestureRecognizer(target: self, action : #selector(OnTabSelected(sender:)))
        secondTabLabelTap.name = SECOND_TAB
        secondTabLabel.addGestureRecognizer(secondTabLabelTap)
        
        let timingRepo = TrainTimingRepository()
        metroTimings = timingRepo.getTrainTimings(sourceStation: stationName!)
    }
    
    @objc func OnTabSelected(sender: UIGestureRecognizer) {
        if selectedTab.compare(sender.name!) != ComparisonResult.orderedSame {
            switch sender.name {
            case FIRST_TAB:
                selectedTab = FIRST_TAB
                firstTabLabel.textColor = UIColor(displayP3Red: 0.082, green: 0.412, blue: 0.78, alpha: 1.0)
                secondTabLabel.textColor = UIColor(displayP3Red: 0.447, green: 0.447, blue: 0.447, alpha: 1.0)
                break
            case SECOND_TAB:
                selectedTab = SECOND_TAB
                secondTabLabel.textColor = UIColor(displayP3Red: 0.082, green: 0.412, blue: 0.78, alpha: 1.0)
                firstTabLabel.textColor = UIColor(displayP3Red: 0.447, green: 0.447, blue: 0.447, alpha: 1.0)
                break
            default:
                break
            }
            
            self.trainTimingsTableView.reloadData()
        }
        
        
    }
    
    func validateTabsTitle() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectedTab {
        case FIRST_TAB:
            return (metroTimings?.towardsChandpole?.count)!
        case SECOND_TAB:
            return (metroTimings?.towardsMansarovar?.count)!
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainTimeTableViewCell", for: indexPath) as! TrainTimeTableViewCell
        cell.serialNoLabel.text = String(indexPath.row + 1)
        
        switch selectedTab {
        case FIRST_TAB:
            cell.trainTimeLabel.text = metroTimings?.towardsChandpole?[indexPath.row].trainTiming
            break
        case SECOND_TAB:
            cell.trainTimeLabel.text = metroTimings?.towardsMansarovar?[indexPath.row].trainTiming
        default:
            break
        }
        
        return cell
    }
    
    @IBOutlet weak var firstTabLabel: UILabel!
    @IBOutlet weak var secondTabLabel: UILabel!
    
    @IBOutlet weak var trainTimingsTableView: UITableView!
}

class TrainTimeTableViewCell : UITableViewCell {
    
    @IBOutlet weak var serialNoLabel: UILabel!
    @IBOutlet weak var trainTimeLabel: UILabel!
}
