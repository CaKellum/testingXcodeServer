//
//  SPDLocationSpeedCheckerDelegateMock.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationSpeedCheckerDelegateMock: SPDLocationSpeedCheckerDelegate {
    var didChangeExceedingMaxSpeed = false
    
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker) {
        didChangeExceedingMaxSpeed = true
    }
}
