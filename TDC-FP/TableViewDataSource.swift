//
//  TableViewDataSource.swift
//  TDC-FP
//
//  Created by Trond Bordewich on 11.10.2015.
//  Copyright © 2015 Trobe. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<I>: NSObject, UITableViewDataSource, UITableViewDelegate {
    typealias CellFactory = (UITableView, NSIndexPath, I) -> UITableViewCell
    
    
    var items:[I] = []
    var cellFactory: CellFactory! = nil
    
    override init(){
        super.init()
    }
    
    func itemAtRow(rowIndex: Int) -> I {
        return self.items[rowIndex]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellFactory(tableView, indexPath, itemAtRow(indexPath.row))
    }
}
