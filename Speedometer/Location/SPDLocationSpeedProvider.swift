//
//  SPDLocationSpeedProvider.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/3/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject

protocol SPDLocationSpeedProviderDelegate: class {
    
    func didUpdate(speed: CLLocationSpeed)
}

protocol SPDLocationSpeedProvider: class {
    var delegate: SPDLocationSpeedProviderDelegate? { get set }
}

class SPDDefaultLocationSpeedProvider {
    weak var delegate: SPDLocationSpeedProviderDelegate?
    let locationProvider: SPDLocationProvider
    
    init(locationProvider: SPDLocationProvider) {
        self.locationProvider = locationProvider
        locationProvider.add(self)
    }
}

extension SPDDefaultLocationSpeedProvider: SPDLocationSpeedProvider {
    
}

extension SPDDefaultLocationSpeedProvider: SPDLocationConsumer {
    
    func consumeLocation(_ location: CLLocation) {
        let speed = max(location.speed, 0)
        
        delegate?.didUpdate(speed: speed)
    }
}

class SPDLocationSpeedProviderAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SPDLocationSpeedProvider.self, factory: { r in
            let locationProvider = r.resolve(SPDLocationProvider.self)!
            
            return SPDDefaultLocationSpeedProvider(locationProvider: locationProvider)
        }).inObjectScope(.weak)
    }
}
