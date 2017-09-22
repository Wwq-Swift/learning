//
//  MapViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/20.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var area: DatasMo!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coder = CLGeocoder()
        coder.geocodeAddressString((area.areas! + area.areasName!)) { (ps, error) in
            guard let ps = ps else {
                print(error ?? "未知错误")
                return
            }
            
            let place = ps.first
            let annotation = MKPointAnnotation()
            annotation.title = self.area.areasName
            annotation.subtitle = self.area.areasDescribe
            
            if let loc = place?.location {
                annotation.coordinate = loc.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
