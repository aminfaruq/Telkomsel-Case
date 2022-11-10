//
//  FeedLocalizationTest.swift
//  EssentialFeediOSTests
//
//  Created by Amin faruq on 21/09/22.
//

import XCTest
import TelkomselModule

final class FeedLocalizationTest: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
    
}
