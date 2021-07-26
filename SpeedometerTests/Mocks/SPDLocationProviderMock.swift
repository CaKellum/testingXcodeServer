//
//  SPDLocationProviderMock.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationProviderMock: SPDLocationProvider {
    var lastConsumer: SPDLocationConsumer?
    
    func add(_ consumer: SPDLocationConsumer) {
        lastConsumer = consumer
    }
}
