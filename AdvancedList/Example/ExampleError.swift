//
//  ExampleError.swift
//  AdvancedList
//
//  Created by Christian Elies on 08.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum ExampleError: Error {
    case requestTimedOut
}

extension ExampleError: CustomStringConvertible {
    var description: String {
        return "The request timed out."
    }
}
