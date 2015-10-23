//
//  ViewController.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 28.09.15.
//  Copyright © 2015 Lingit AS. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    @IBOutlet weak var matchEventsTableView: UITableView!
    var events = [MatchEvent]()
    let dataSource = TableViewDataSource<MatchEvent>()
    let disposebag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDatasource()

        let matchEvents = webSocketMessages
                            .shareReplay(30)
                            .map( toMatchEventFromJsonString )
        
        matchEvents.subscribeNext( updateTableViewWithMatchEvent )
        
        matchEventsTableView
            .rx_itemSelected // Valgt celle
            .map( toFilteredMatchFunction ) // Map til valgtKampFunksjon
            .subscribeNext { (filterMatches) in
                let filteredMatches = filterMatches(matchEvents) //Filtrer kamper av interesse
                self.showDetailsForObservable(filteredMatches) //Vis detalj for valgt kamp
            }
    }
}


