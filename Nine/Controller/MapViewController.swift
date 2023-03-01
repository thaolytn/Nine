//
//  ViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 2/27/23.
//

import UIKit
import MapboxMaps
import MapboxCoreMaps
import MapboxCommon_Private
import MapboxCoreMaps_Private


class MapViewController: UIViewController {

    internal var mapView: MapView!
    internal let STYLE_URL = "mapbox://styles/thaolyngo/ckdq24xor0rv81iqgphyie5qg"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a mapView
        let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoidGhhb2x5bmdvIiwiYSI6ImNsZW43ZDNqZTE4cXMzcm5oamU5cXM1eTIifQ.YOrnBSD-avGEriAFfE6X3Q")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, styleURI: StyleURI(rawValue: STYLE_URL))
        
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    
        // Hide scale bar & compass
        mapView.ornaments.options.scaleBar.visibility = .hidden
        mapView.ornaments.options.compass.visibility = .hidden

        
        // Set the mapView to the current view
        view.addSubview(mapView)
        
        
        // Restrict the map bounds
        let northeast = CLLocationCoordinate2D(latitude: 41.003977, longitude: -73.516367)
        let southwest = CLLocationCoordinate2D(latitude: 40.508105, longitude: -74.335879)
        let bounds = CoordinateBounds(southwest: southwest, northeast: northeast)
        
        try? mapView.mapboxMap.setCameraBounds(with: CameraBoundsOptions(bounds: bounds))
        
        
        // Center the map area over Manhattan
        let center = CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855)
        
        mapView.mapboxMap.setCamera(
            to: CameraOptions(
                center: center,
                zoom: 12.0
            )
        )
        
        
        // Programmatically add About button
        let aboutImage = UIImage(named: "nine-flower")
        let aboutButton = UIButton(type: .custom)
        
        
    }
    
    
    //MARK: - Segue Methods
    
    @objc func handleAboutButtonTap() {
        print("About button tapped")
        performSegue(withIdentifier: "goToAbout", sender: self)
    }

    @objc func handleListButtonTap() {
        print("List button tapped")
        performSegue(withIdentifier: "goToList", sender: self)
    }
    
    
}

