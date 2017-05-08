//
//  BackendError.swift
//
//  Created by David on 06/04/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}
