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
import CombineLabModel

class FirstViewController: UIViewController {
    
    @IBOutlet private weak var fetchUserButton: UIButton!
    @IBOutlet private weak var userLabel: UILabel!
    
    private var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserButton.publisher(for: .touchUpInside)
            .throttle(for: 1, scheduler: RunLoop.main, latest: false)
            .flatMap { _ in
                CombineLabAPI.userPublisher()
                    .catch { error -> Empty<User, Never> in
                        print("Received error: \(error)")
                        return Empty()
                    }
            }
            .map { String(describing: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \UILabel.text, on: userLabel)
            .store(in: &cancellables)
    }
}
