//
//  CombineLabModel.swift
//  CombineLabModel
//
//  Created by Carlo Rapisarda on 10/3/19.
//  Copyright © 2019 Carlo Rapisarda. All rights reserved.
//

import Foundation

public struct User: Codable {
    let name: String
    let identifier: String
    
    public init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
    }
}
