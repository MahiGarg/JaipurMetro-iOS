//
//  MetroRouteViewController.swift
//  Jaipur Metro
//
//  Created by mahi
//  Copyright © 2022 mahi. All rights reserved.
//

import UIKit

class MetroRouteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Metro Route"
        
        let metroRouteImage = UIImage(named: "metro_route")
        metroRouteImageScrollView.display(image: metroRouteImage!)
    }

    @IBOutlet weak var metroRouteImageScrollView: ImageScrollView!
    
    
}
