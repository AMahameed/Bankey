//
//  AccountsTest.swift
//  BankeyUnitTests
//
//  Created by Abdallah Mahameed on 15/09/2022.
//

import Foundation
import XCTest

@testable import Bankey

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """

        let data = json.data(using: .utf8)!
        let isoDecoder = JSONDecoder()
        isoDecoder.dateDecodingStrategy = .iso8601
        let result = try! isoDecoder.decode([Account].self, from: data)
        
        XCTAssertEqual(result[0].createdDateTime.monthDayYearString, "Jun 21, 2010")
        
        
        
    }
}
