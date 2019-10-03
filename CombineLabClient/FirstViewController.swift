//
//  FirstViewController.swift
//  CombineLabClient
//
//  Created by Carlo Rapisarda on 10/3/19.
//  Copyright © 2019 Carlo Rapisarda. All rights reserved.
//

import UIKit
import Combine
import CombineLabAPI

class FirstViewController: UIViewController {
    
    private var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CombineLabAPI.userPublisher()
            .sink(receiveCompletion: {
                print("Received completion: \($0)")
            }, receiveValue: {
                print("Received user: \($0)")
            })
            .store(in: &cancellables)
    }
}
