//
//  MatchDetailViewControllerExtensions.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 28.09.15.
//  Copyright © 2015 Trobe. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension MatchDetailViewController {
 
    func prepareTableView() {
        skinTableViewDataSource(dataSource)
        matchDetailsTableView.dataSource = dataSource
        matchDetailsTableView.rowHeight = UITableViewAutomaticDimension
        matchDetailsTableView.estimatedRowHeight = 50
    }
    
    func skinTableViewDataSource(dataSource: TableViewDataSource<MatchEvent>) {
        dataSource.cellFactory = { (tv, ip, i) in
            guard let cell = tv.dequeueReusableCellWithIdentifier("MatchEventDetails") as? MatchEventTableViewCell else {
                return UITableViewCell(style:.Default, reuseIdentifier:"MatchEventDeatils")
            }
            cell.descriptiveTextLabel!.text = i.message
            cell.matchNameLabel!.text = teamNameForMatchID(i.matchId)
            cell.eventImageView!.image = imageForEventType(i.type)
            return cell
        }
    }
        
    func updateDetailsTableView(matchEvents:[MatchEvent]) {
        self.dataSource.items = matchEvents
        self.matchDetailsTableView.reloadData()
    }
    
    func toSearchFunction(message: String) -> ([MatchEvent] -> [MatchEvent])  {
        return { (events) in
            if !message.isEmpty {
                return events.filter({ $0.message.containsString(message)})
            }
            return events
        }
    }
    
    func toSearchResult(search:([MatchEvent] -> [MatchEvent]), items:[MatchEvent]) -> [MatchEvent] {
        return search(items)
    }
}