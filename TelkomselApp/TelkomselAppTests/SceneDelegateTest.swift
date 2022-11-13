//
//  SceneDelegateTest.swift
//  EssentialAppTests
//
//  Created by Amin faruq on 01/10/22.
//

import XCTest
import TelkomseliOS
@testable import TelkomselApp

class SceneDelegateTest: XCTestCase {
    
    func test_configureWindow_setsWindowAsKeyAndVisible() {
        let window = UIWindowSpy()
        let sut = SceneDelegate()
        sut.window = window
        
        sut.configureWindow()
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1, "Expected to make window key and visible")
    }
    
    func test_configureWindow_configuresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindowSpy()
        
        sut.configureWindow()
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UITabBarController
        
        XCTAssertNotNil(rootNavigation, "Expected a tabbar controller as root, got \(String(describing: root)) instead")
    }
    
    private class UIWindowSpy: UIWindow {
        var makeKeyAndVisibleCallCount = 0
        
        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount = 1
        }
    }

}
