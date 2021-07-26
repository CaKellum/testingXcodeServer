//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/3/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembler {
    var resolver: Resolver {
        return assembler.resolver
    }
    private let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
    
    init() {
        assembler.apply(assembly: SPDLocationManagerAssembly())
        assembler.apply(assembly: SPDLocationAuthorizationAssembly())
        assembler.apply(assembly: SPDLocationProviderAssembly())
        assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
        assembler.apply(assembly: SPDlocationSpeedCheckerAssembly())
        
        assembler.apply(assembly: ViewControllerAssembly())
        
        if ProcessInfo.processInfo.arguments.contains("UITests") {
            assembler.apply(assembly: SPDLocationManagerUITestMockAssembly())
        }
    }
}
