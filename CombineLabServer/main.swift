//
//  main.swift
//  CombineLabServer
//
//  Created by Carlo Rapisarda on 10/3/19.
//  Copyright © 2019 Carlo Rapisarda. All rights reserved.
//

import Foundation
import Vapor
import CombineLabModelMac

func logRequest(_ path: String) {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = .current
    formatter.formatOptions = [.withFractionalSeconds, .withFullTime]
    print("[\(formatter.string(from: Date()))] \(path)")
}

let app = try Application()
let router = try app.make(Router.self)

router.get("hello") { req -> String in
    logRequest(req.http.url.path)
    return "Hello, world."
}

router.get("user") { req -> User in
    logRequest(req.http.url.path)
    return User(name: "Mario", identifier: UUID().uuidString)
}

try app.run()
