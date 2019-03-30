//
//  Saga.swift
//  ReSwift-Sagas
//
//  Created by Jason Prasad on 2/13/19.
//  Copyright © 2019 ReSwift. All rights reserved.
//

import ReSwift

public typealias Effects<State> = (
    call: (() -> Void) -> Void,
    put: (Action) -> Void,
    select: () -> State,
    take: ((Action) -> Bool) -> Action
)

public typealias Saga<State> = (Effects<State>) -> Void

func createSagaMiddleware<State>(_ sagas: Saga<State>...) -> Middleware<State> {
    let runner = Runner<State>(sagas)
    return { dispatch, getState in
        return { next in
            return { action in
                next(action)
                runner.put(action)
            }
        }
    }
}

class Runner<State> {
    
    init(_ sagas: [Saga<State>]) {
        sagas.forEach {
            print($0)
        }
    }
    
    func put(_ action: Action) {}
    
}
