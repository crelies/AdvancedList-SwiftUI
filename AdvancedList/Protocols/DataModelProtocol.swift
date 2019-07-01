//
//  DataModelProtocol.swift
//  AdvancedList
//
//  Created by Christian Elies on 01.07.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import Foundation
import SwiftUI

protocol DataModelProtocol {
    var identifier: String { get }
    var rowView: AnyView { get }
}
