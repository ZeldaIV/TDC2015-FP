//
//  Helpers.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 12.10.2015.
//  Copyright © 2015 Trobe. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

func toMatchEventFromJsonString(jsonString: String) -> MatchEvent {
    return parseJSON(convertToJsonData(jsonString))
}

func imageForEventType(type:String) -> UIImage {
    switch type {
    case "chance":
        return UIImage(named: "Chance")!
    case "penalty":
        return UIImage(named: "Penalty")!
    case "sub":
        return UIImage(named: "Substitute")!
    case "yellow":
        return UIImage(named: "YellowCard")!
    default:
        return UIImage()
    }
}

func teamNameForMatchID(matchId:String) -> String {
    switch matchId {
    case "BARREA":
        return "Barcelona - Real Madrid"
    case "MANARS":
        return "Manchester United - Arsenal"
    default:
        return "New teams?"
    }
}

func parseJSON(jsonData: NSData) -> MatchEvent {
    let json = JSON(data: jsonData)
    let matchId = json["matchId"].string
    let eventType = json["type"].string
    let message = json["message"].string
    let matchEvent = MatchEvent(matchId:matchId!, type:eventType!, message:message!)
    return matchEvent
}

func convertToJsonData(jsonString: String) -> NSData {
    return jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)!
}