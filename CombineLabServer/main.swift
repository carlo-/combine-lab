//
//  main.swift
//  CombineLabServer
//
//  Created by Carlo Rapisarda on 10/3/19.
//  Copyright © 2019 Carlo Rapisarda. All rights reserved.
//

import Vapor
import CombineLabModelMac

let app = try Application()
let router = try app.make(Router.self)

router.get("hello") { req in
    return "Hello, world."
}

router.get("user") { req in
    return User(name: "Mario", identifier: "Rossi")
}

try app.run()
