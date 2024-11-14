//
//  Double.swift
//  CryptoApp
//
//  Created by Rahul Rai on 13/11/24.
//

import Foundation

extension Double {
    
    /// Computed property to convert double to currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56

    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // Default value
        //formatter.currencyCode = "usd" // Change currency
        //formatter.currencySymbol = "$" // Change currency symbol
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    /// Computed property to convert double to currency as a string with 2 decimal places
    ///  ```
    ///    Convert 1234.56 to "$1,234.56"

    ///    ```
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    /// Computed property to convert double to currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current // Default value
        //formatter.currencyCode = "usd" // Change currency
        //formatter.currencySymbol = "$" // Change currency symbol
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        
        return formatter
    }
    
    /// Computed property to convert double to currency as a string with 2-6 decimal places
    ///  ```
    ///    Convert 1234.56 to "$1,234.56"
    ///    Convert 12.3456 to "$12.3456"
    ///    Convert 0.123456 to "$0.123456"
    ///    ```
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert double to String representation
    ///  ```
    ///    Convert 1234.56 to 1.23
    ///    Convert 12.3456 to 12.34
    ///    Convert 0.123456 to 0.12
    ///    ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert double to String representation with percentage symbol
    ///  ```
    ///    Convert 1234.56 to "1.23%"
    ///    ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
