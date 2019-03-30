//
//  ReSwift_SagasTests.swift
//  ReSwift-SagasTests
//
//  Created by Jason Prasad on 2/13/19.
//  Copyright © 2019 ReSwift. All rights reserved.
//

import ReSwift
import XCTest
@testable import ReSwift_Sagas

struct Action: ReSwift.Action {}
struct State: StateType {}

class ReSwift_SagasTests: XCTestCase {
    
    func testRunner() {
        func saga(_ effects: Effects<State>) -> Void {
            effects.put(Action())
            let action = effects.take { $0 is Action }
            effects.call {
                // TODO: can this be a retain?
                effects.put(action)
            }
        }
        
        _ = Store<State>(reducer: { _, _ in State() },
                         state: nil,
                         middleware: [createSagaMiddleware(saga)])
    }
    
}
