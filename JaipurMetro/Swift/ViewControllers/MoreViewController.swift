//
//  MoreViewController.swift
//  JaipurMetro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit
import StoreKit
import GoogleMobileAds

class MoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initClickEvents()
    }
       
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false;
        self.title = "More"
    }
    
    fileprivate func initClickEvents(){
        
        let stationsOnMapGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        stationsOnMapGR.name = NAME_STATIONS_ON_MAP
        stationsOnMapView.addGestureRecognizer(stationsOnMapGR)
        
        let visitOfficialWebsiteGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        visitOfficialWebsiteGR.name = NAME_VISIT_OFFICIAL_WEBSITE
        visitOfficialWebsiteView.addGestureRecognizer(visitOfficialWebsiteGR)
        
        
        let shareThisAppGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        shareThisAppGR.name = NAME_SHARE_THIS_APP
        shareThisAppView.addGestureRecognizer(shareThisAppGR)
        
        let giveFeedbackGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        giveFeedbackGR.name = NAME_GIVE_FEEDBACK
        giveFeedbackView.addGestureRecognizer(giveFeedbackGR)
        
//        let checkAndroidAppsGR = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
//        checkAndroidAppsGR.name = NAME_CHECK_ANDROID_APPS
//        checkAndroidAppsView.addGestureRecognizer(checkAndroidAppsGR)
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        switch sender.name {
        case NAME_STATIONS_ON_MAP:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let stationDetainsVC = storyBoard.instantiateViewController(withIdentifier: "StationsOnMapViewController")
                as! StationsOnMapViewController
            
            self.navigationController?.pushViewController(stationDetainsVC, animated: true)
            self.title = nil
            
            self.tabBarController?.tabBar.isHidden = true;
            break
            
        case NAME_VISIT_OFFICIAL_WEBSITE:
            UIApplication.shared.open(URL(string: Utils.JaipurMetroWebsite)!)
            break
            
        
            
        case NAME_SHARE_THIS_APP:
            let sharingTitle = "Download Jaipur Metro app"
            let shareString = "Hi \n\nDownload the Jaipur Metro app from the link below with all the features including metro routes, " +
            "fares, metro timings from all the stations, station details with contact numbers and passenger amenities. " +
            "The app is available on both iOS and Android platforms.\n \n" + Utils.OneLink
            
            let activityViewController = UIActivityViewController(activityItems: [shareString],applicationActivities: nil)
            activityViewController.setValue(sharingTitle, forKey: "Subject")
            let currentViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            currentViewController.present(activityViewController, animated: true, completion: nil);
            break
            
        case NAME_GIVE_FEEDBACK:
            openMailApp()
            break
            
        
            
        default:
            break
        }
    }
    
    func openMailApp() {
        let subject = "Suggestions @JaipurMetroApp"
        let coded = "mailto:mahigarg@gmail.com?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if let emailURL: NSURL = NSURL(string: coded!) {
            if UIApplication.shared.canOpenURL(emailURL as URL) {
                UIApplication.shared.open(emailURL as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    let NAME_STATIONS_ON_MAP = "stations_on_map"
    let NAME_VISIT_OFFICIAL_WEBSITE = "visit_official_website"
    let NAME_RATE_THIS_APP = "rate_this_app"
    let NAME_SHARE_THIS_APP = "share_this_app"
    let NAME_GIVE_FEEDBACK = "give_feedback"
    let NAME_OTHER_IOS_APPS = "other_ios_apps"
    let NAME_CHECK_ANDROID_APPS = "check_android_apps"
    
    
    @IBOutlet weak var stationsOnMapView: UIView!
    @IBOutlet weak var visitOfficialWebsiteView: UIView!
    @IBOutlet weak var rateThisAppView: UIView!
    @IBOutlet weak var shareThisAppView: UIView!
    @IBOutlet weak var giveFeedbackView: UIView!
    @IBOutlet weak var otheriOSAppsView: UIView!
    //@IBOutlet weak var checkAndroidAppsView: UIView!
   
    
    
}
