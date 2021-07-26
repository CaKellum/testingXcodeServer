//
//  SPDLocationSpeedProviderDelegateMock.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationSpeedProviderDelegateMock: SPDLocationSpeedProviderDelegate {
    var lastSpeed: CLLocationSpeed?
    
    func didUpdate(speed: CLLocationSpeed) {
        lastSpeed = speed
    }
}

