//
//  CurrencyFormatterTest.swift
//  BankeyUnitTests
//
//  Created by Abdallah Mahameed on 12/09/2022.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws{
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws{
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
//        XCTAssertEqual(result, "$0.0")
    }
    
    func testZeroDollarsFormatted() throws{
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00s")
        
    }
}
