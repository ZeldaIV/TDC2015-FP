//
//  MatchDetailViewController.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 03.10.2015.
//  Copyright © 2015 Trobe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MatchDetailViewController: UIViewController {
    @IBOutlet weak var matchEventSearchBar: UISearchBar!
    @IBOutlet weak var matchDetailsTableView: UITableView!
    let items = Variable([MatchEvent]())
    let dataSource = TableViewDataSource<MatchEvent>()
    var observable: Observable<MatchEvent>! = nil
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        
        observable
            .subscribeNext { (matchEvent) in
                self.items.value.insert(matchEvent, atIndex: 0)
            }
//        items.subscribeNext( updateDetailsTableView )
        
        let searchFunction = matchEventSearchBar
            .rx_text
            .map( toSearchFunction )
        
        combineLatest(searchFunction, items, toSearchResult)
            .subscribeNext( updateDetailsTableView )
    }
}

