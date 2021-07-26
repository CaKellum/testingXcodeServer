//
//  SPDLocationManager.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/3/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject

protocol SPDLocationManagerDelegate: class {
    
    func locationManager(_ manager: SPDLocationManager, didUpdateLocations locations: [CLLocation])
}

protocol SPDLocationManagerAuthorizationDelegate: class {
    
    func locationManager(_ manager: SPDLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
}

protocol SPDLocationManager: class {
    var delegate: SPDLocationManagerDelegate? { get set }
    var authorizationDelegate: SPDLocationManagerAuthorizationDelegate? { get set }
    var authorizationStatus: CLAuthorizationStatus { get }
    
    func requestWhenInUseAuthorization()
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

class SPDLocationManagerProxy: NSObject {
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    
    let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        
        super.init()
        
        locationManager.delegate = self
    }
}

extension SPDLocationManagerProxy: SPDLocationManager {
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension SPDLocationManagerProxy: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationManager(self, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationDelegate?.locationManager(self, didChangeAuthorization: status)
    }
}

class SPDLocationManagerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SPDLocationManager.self, factory: { r in
            let locationManager = CLLocationManager()
            
            return SPDLocationManagerProxy(locationManager: locationManager)
        }).inObjectScope(.weak)
    }
}
