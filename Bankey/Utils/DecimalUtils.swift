//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Abdallah Mahameed on 8/18/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
