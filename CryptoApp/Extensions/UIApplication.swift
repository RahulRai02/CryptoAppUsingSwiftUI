//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Rahul Rai on 21/11/24.
//

import Foundation
import SwiftUI

// Made this extension in order to dismiss the keyboard when we click on the clear button ....

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
