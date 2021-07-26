//
//  SPDLocationSpeedCheckerTests.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/4/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import XCTest
@testable import Speedometer
import CoreLocation

class SPDLocationSpeedCheckerTests: XCTestCase {
    var sut: SPDLocationSpeedChecker!
    
    var locationProviderMock: SPDLocationProviderMock!
    var delegateMock: SPDLocationSpeedCheckerDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        locationProviderMock = SPDLocationProviderMock()
        delegateMock = SPDLocationSpeedCheckerDelegateMock()
        
        sut = SPDDefaultLocationSpeedChecker(locationProvider: locationProviderMock)
        sut.delegate = delegateMock
    }
    
    func test_isExceedingMaximumSpeed_maximumSpeedIsNil_false() {
        // Arrange
        sut.maximumSpeed = nil
        let location = createLocation(with: 1000)
        
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(location)
        
        // Assert
        XCTAssertFalse(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maximumSpeedNotExceeded_false() {
        // Arrange
        sut.maximumSpeed = 100
        let location = createLocation(with: 90)
        
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(location)
        
        // Assert
        XCTAssertFalse(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maximumSpeedExceeded_true() {
        // Arrange
        sut.maximumSpeed = 100
        let location = createLocation(with: 110)
        
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(location)
        
        // Assert
        XCTAssertTrue(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maximumSpeedExceeded_delegateIsInformed() {
        // Arrange
        sut.maximumSpeed = 100
        let location = createLocation(with: 110)
        
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(location)
        
        // Assert
        XCTAssertTrue(delegateMock.didChangeExceedingMaxSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maximumSpeedSetToExceededValue_true() {
        // Arrange
        let location = createLocation(with: 110)
        locationProviderMock.lastConsumer?.consumeLocation(location)
        
        // Act
        sut.maximumSpeed = 100
        
        // Assert
        XCTAssertTrue(sut.isExceedingMaximumSpeed)
    }
    
    func test_isExceedingMaximumSpeed_maximumSpeedSetToExceededValue_delegateIsInformed() {
        // Arrange
        let location = createLocation(with: 110)
        locationProviderMock.lastConsumer?.consumeLocation(location)
        
        // Act
        sut.maximumSpeed = 100
        
        // Assert
        XCTAssertTrue(delegateMock.didChangeExceedingMaxSpeed)
    }
    
    func test_isExceedMaximumSpeed_propertyDoesNotChange_delegateIsNotInformed() {
        // Arrange
        sut.maximumSpeed = 100
        let firstLocation = createLocation(with: 110)
        let secondLocation = createLocation(with: 115)
        locationProviderMock.lastConsumer?.consumeLocation(firstLocation)
        delegateMock.didChangeExceedingMaxSpeed = false
        
        // Act
        locationProviderMock.lastConsumer?.consumeLocation(secondLocation)
        
        // Assert
        XCTAssertFalse(delegateMock.didChangeExceedingMaxSpeed)
    }
    
    func createLocation(with speed: CLLocationSpeed) -> CLLocation {
        let coordinate = CLLocationCoordinate2D()
        return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: speed, timestamp: Date())
    }
    
    
    
}
