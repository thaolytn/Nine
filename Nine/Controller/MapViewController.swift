//
//  ViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 2/27/23.
//

import UIKit
import MapboxMaps
import MapboxCoreMaps


class MapViewController: UIViewController {

    private var mapView: MapView!
    
    private enum Constants {
        static let STYLE_URL = "mapbox://styles/thaolyngo/ckdq24xor0rv81iqgphyie5qg"
        static let PUBLIC_TOKEN = "pk.eyJ1IjoidGhhb2x5bmdvIiwiYSI6ImNsZW43ZDNqZTE4cXMzcm5oamU5cXM1eTIifQ.YOrnBSD-avGEriAFfE6X3Q"
        static let SOURCE_ID = "NINE_FEATURES"
        static let LAYER_ID = "NINE_SYMBOLS"
        static let LOCATION_ICON_ID = "NINE_LOCATION_ICON"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a mapView
        let myResourceOptions = ResourceOptions(accessToken: Constants.PUBLIC_TOKEN)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, styleURI: StyleURI(rawValue: Constants.STYLE_URL))
        
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
        aboutButton.frame = CGRect(x: 0.8, y: 30, width: 110, height: 110)
        aboutButton.setImage(aboutImage, for: .normal)
        aboutButton.addTarget(self, action: #selector(handleAboutButtonTap(_:)), for: .touchUpInside)
        view.addSubview(aboutButton)
        
        
        // Programmatically add List button
        let listImage = UIImage(named: "list-button")
        let listButton = UIButton(type: .custom)
        listButton.frame = CGRect(x: 260, y: 60, width: 120, height: 60)
        listButton.setImage(listImage, for: .normal)
        listButton.addTarget(self, action: #selector(handleListButtonTap(_:)), for: .touchUpInside)
        view.addSubview(listButton)
        
        
        
        mapView.mapboxMap.onNext(event: .mapLoaded) { _ in
            self.prepareStyle()
        }
        
    }
    
    
    //MARK: - Utility Methods
    
    private func prepareStyle() {
        
        let style = mapView.mapboxMap.style
        try? style.addImage(UIImage(named: "location-icon")!, id: Constants.LOCATION_ICON_ID)
        
        // Add GeoJSON data source to the map's style
        if let geoJSONFileURL = Bundle.main.url(forResource: "NineFeatures", withExtension: "geojson") {
            var geoJSONSource = GeoJSONSource()
            geoJSONSource.data = .url(geoJSONFileURL)
            
            try! style.addSource(geoJSONSource, id: Constants.SOURCE_ID)
        }
        
        var symbolLayer = SymbolLayer(id: Constants.LAYER_ID)
        symbolLayer.source = Constants.SOURCE_ID
        
        symbolLayer.iconImage = .constant(.name(Constants.LOCATION_ICON_ID))
        symbolLayer.iconAnchor = .constant(.bottom)
        symbolLayer.iconAllowOverlap = .constant(false)
        
        symbolLayer.textField = .expression(Exp(.get) { "name" })
        symbolLayer.textSize = .constant(12)
        symbolLayer.textColor = .constant(.init(UIColor.white))
        symbolLayer.textAnchor = .constant(.top)
        
        try! style.addLayer(symbolLayer)
        
        
    }
    
    
    
    
    
    //MARK: - Segue Methods
    
    @objc func handleAboutButtonTap(_ sender: UIButton!) {
        print("About button tapped")
        performSegue(withIdentifier: "goToAbout", sender: self)
    }

    @objc func handleListButtonTap(_ sender: UIButton) {
        print("List button tapped")
        performSegue(withIdentifier: "goToList", sender: self)
    }
    
    
}

