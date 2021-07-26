//
//  SPDLocationManagerMock.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationManagerMock: SPDLocationManager {
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var requestedWhenInUseAuthorization = false
    var didStartUpdatingLocation = false
    var didStopUpdatingLocation = false
    
    func requestWhenInUseAuthorization() {
        requestedWhenInUseAuthorization = true
    }
    
    func startUpdatingLocation() {
        didStartUpdatingLocation = true
    }
    
    func stopUpdatingLocation() {
        didStopUpdatingLocation = true
    }
}
