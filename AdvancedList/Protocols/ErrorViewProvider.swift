//
//  ErrorViewProvider.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

protocol ErrorViewProvider: class {
    var errorView: AnyView { get }
}
