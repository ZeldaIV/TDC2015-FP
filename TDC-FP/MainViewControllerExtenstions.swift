//
//  MainViewControllerExtenstions.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 11.10.2015.
//  Copyright © 2015 Trobe. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension MainViewController {
    
    func prepareDatasource() {
        skinTableViewDataSource(dataSource)
        matchEventsTableView.dataSource = dataSource
        matchEventsTableView.rowHeight = UITableViewAutomaticDimension
        matchEventsTableView.estimatedRowHeight = 50
    }
    
    func skinTableViewDataSource(dataSource: TableViewDataSource<MatchEvent>) {
        dataSource.cellFactory = { (tv, ip, i) in
            guard let cell = tv.dequeueReusableCellWithIdentifier("MatchEvent") as? MatchEventTableViewCell else {
                return UITableViewCell(style:.Default, reuseIdentifier:"MatchEvent")
            }
            cell.descriptiveTextLabel!.text = i.message
            cell.matchNameLabel!.text = teamNameForMatchID(i.matchId)
            cell.eventImageView!.image = imageForEventType(i.type)
            return cell
        }
    }
    
    func updateTableViewWithMatchEvent(matchEvent: MatchEvent) {
        self.dataSource.items.insert(matchEvent, atIndex: 0)
        self.matchEventsTableView.beginUpdates()
        self.matchEventsTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
        self.matchEventsTableView.endUpdates()
    }
    
    func showDetailsForObservable(observableMatchEvents:Observable<MatchEvent>) {
        let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = sb.instantiateViewControllerWithIdentifier("MatchDetailViewController") as! MatchDetailViewController
        vc.observable = observableMatchEvents
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func toFilteredMatchFunction(indexPath:NSIndexPath) -> (Observable<MatchEvent> -> Observable<MatchEvent>) {
        return { (observable) in
            let matchId = self.dataSource.itemAtRow(indexPath.row).matchId
            return observable.filter( { $0.matchId == matchId } )
        }
    }
}
