//
//  OrderHistoryViewController.swift
//  BookATest
//
//  Created by Rasika on 6/23/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit
import CoreData

class OrderHistoryViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    var tableView = UITableView()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var orderArray:[OrderDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        
        self.fetchData()
        self.tableView.reloadData()
        
        tableView.contentInset.top = 20
        tableView = UITableView(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerNib(UINib(nibName: "OrderTableCellTableViewCell", bundle: nil), forCellReuseIdentifier: ORDER_CELL_IDENTIFIER)
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchData()
        self.tableView.reloadData()
        
        self.navigationController!.topViewController!.title = ORDER_HISTORY_TITLE;
    }

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(){
        
        let entityDescription =
            NSEntityDescription.entityForName(ORDER_DETAIL_ENTITY,
                                              inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let dateSorter = NSSortDescriptor(key: "date",ascending:false)
        let sortDescriptors = [dateSorter]
        request.sortDescriptors = sortDescriptors
            
        do {
             orderArray =
                try managedObjectContext.executeFetchRequest(request) as! [OrderDetail]
            
        } catch let error as NSError {
            print(error)
        }
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 154
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ORDER_CELL_IDENTIFIER) as! OrderTableCellTableViewCell
        let orderHistory = orderArray[indexPath.row]
        cell.name.text = orderHistory.firstName
        cell.test.text = orderHistory.testName
        cell.date.text = dateToString(orderHistory.date!)
        
        return cell
    }
    
    

}
