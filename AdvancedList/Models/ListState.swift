//
//  ListState.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation

enum ListState: CaseIterable {
    case error
    case items
    case loading
}

extension ListState: Equatable {
    static func ==(lhs: ListState, rhs: ListState) -> Bool {
        switch (lhs, rhs) {
            case (.error, .error):
                return true
            case (.items, .items):
                return true
            case (.loading, .loading):
                return true
            default:
                return false
        }
    }
}
