//
//  MapViewController.swift
//  Hawkeye Mobile
//
//  Created by Elijah Fergason on 11/17/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
      //  self.mapView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // Add custom imagery as tile overlay to basemap.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
