//
//  API.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 04.10.2015.
//  Copyright © 2015 Lingit AS. All rights reserved.
//

import Foundation
import RxSwift
import SwiftWebSocket


let webSocketMessages = MatchEventObservable().observeAt("ws://localhost:8080/socket")

class MatchEventObservable {
    func observeAt(url: String) -> Observable<String> {
        return create {
            observer in
            WebSocket(url).event.message = {
                (message) in
                if let message = message as? String {
                    observer.on(Event.Next(message))
                }
            }
            return NopDisposable.instance
        }
    }
}