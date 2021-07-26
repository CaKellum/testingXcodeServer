//
//  SPDLocationProviderTests.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import Speedometer
import CoreLocation

class SPDLocationProviderTests: XCTestCase {
    var sut: SPDLocationProvider!
    
    var locationManagerMock: SPDLocationManagerMock!
    var locationAuthorizationMock: SPDLocationAuthorizationMock!
    var consumerMock: SPDLocationConsumerMock!
    
    override func setUp() {
        super.setUp()
        
        locationManagerMock = SPDLocationManagerMock()
        locationAuthorizationMock = SPDLocationAuthorizationMock()
        consumerMock = SPDLocationConsumerMock()
        
        sut = SPDDefaultLocationProvider(locationManager: locationManagerMock, locationAuthorization: locationAuthorizationMock)
        sut.add(consumerMock)
    }
    
    func test_authorizedNotification_startUpdatingLocation() {
        // Arrange
        // Act
        NotificationCenter.default.post(name: .SPDLocationAuthorized, object: locationAuthorizationMock)
        
        // Assert
        XCTAssertTrue(locationManagerMock.didStartUpdatingLocation)
    }
    
    func test_updatedLocations_passesLocationToConsumers() {
        // Arrage
        let expectedLocation = CLLocation()
        
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [expectedLocation])
        
        // Assert
        XCTAssertEqual(expectedLocation, consumerMock.lastLocation)
    }
    
    func test_updatedLocations_noLocations_nothingIsPassedToConsumers() {
        // Arrage
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [])
        
        // Assert
        XCTAssertNil(consumerMock.lastLocation)
    }
    
    func test_updatedLocations_severalLocations_mostRecentLocationIsPassedToConsumers() {
        // Arrange
        let timestamp = Date()
        let oldLocation = createLocation(with: timestamp)
        let newLocation = createLocation(with: timestamp.addingTimeInterval(60))
        
        // Act
        locationManagerMock.delegate?.locationManager(locationManagerMock, didUpdateLocations: [oldLocation, newLocation])
        
        // Assert
        XCTAssertEqual(newLocation, consumerMock.lastLocation)
    }
    
    func test_deinit_stopUpdatingLocation() {
        // Arrange
        // Act
        sut = nil
        
        // Assert
        XCTAssertTrue(locationManagerMock.didStopUpdatingLocation)
    }
    
    func createLocation(with date: Date) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 0, timestamp: date)
    }
    
    
    
    
    
    
}
