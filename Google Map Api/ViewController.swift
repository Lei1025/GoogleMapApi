//
//  ViewController.swift
//  Google Map Api
//
//  Created by Lei Liu on 2018/3/20.
//  Copyright © 2018年 Lei Liu. All rights reserved.
//


import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    
    
    let destinations = [VacationDestination(name: "CN Tower", location: CLLocationCoordinate2DMake(43.642729, -79.387068), zoom: 18), VacationDestination(name: "Casa Loma", location: CLLocationCoordinate2DMake(43.678057, -79.409439), zoom: 18), VacationDestination(name: "High Park", location: CLLocationCoordinate2DMake(43.646742, -79.463680), zoom: 15), VacationDestination(name: "Woodbine Beach", location: CLLocationCoordinate2DMake(43.661894, -79.307856), zoom: 15), VacationDestination(name: "Pearson Airport", location: CLLocationCoordinate2DMake(43.677919, -79.624830), zoom: 13)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA0QlNOrMY6JU7wqgBXBamQq1v9wbR11Z0")
        let camera = GMSCameraPosition.camera(withLatitude: 43.653466, longitude: -79.384084, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(43.653466, -79.384084)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Toronto City Hall"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
    }
    
   @objc func nextAction() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.index(of: currentDestination!), index < destinations.count - 1 {
                currentDestination = destinations[index + 1]
            }
        }
        
        setMapCamera()
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }
    
}



