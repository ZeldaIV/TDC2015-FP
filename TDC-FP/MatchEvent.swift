//
//  MatchEvent.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 05.10.2015.
//  Copyright © 2015 Lingit AS. All rights reserved.
//

import Foundation
import RxSwift

struct MatchEvent: CustomStringConvertible {
    let matchId: String
    let type: String
    let message: String
    
    var description: String {
        return "This is matchId: \(matchId) with event type: \(type) containing message: \(message)"
    }
}