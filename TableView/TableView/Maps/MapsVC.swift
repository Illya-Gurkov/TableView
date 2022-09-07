//
//  MapsVC.swift
//  TableView
//
//  Created by Illya Gurkov on 7.09.22.
//

import UIKit
import MapKit

class MapsVC: UIViewController {

    var user: User?

    @IBOutlet var mapsView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        guard

            let user = user,
            let address = user.address,
            let geo = address.geo,
            let lat = geo.lat,
            let doubleLat = Double(lat),
            let lng = geo.lng,
            let doubleLng = Double(lng)

        else {
            return
        }

        let anatation = MKPointAnnotation()
        anatation.coordinate.latitude = doubleLat // широта
        anatation.coordinate.longitude = doubleLng // долгота
        mapsView.addAnnotation(anatation)
    }
}
