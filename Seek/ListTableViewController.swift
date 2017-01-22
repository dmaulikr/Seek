//
//  ListTableViewController.swift
//  Seek
//
//  Created by Wilson Ding on 1/21/17.
//  Copyright © 2017 Seek. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var timestampArray : [Timestamp] = []
    
    var selectedTime : Float = 0.0
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        navigationController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sortedArray = self.timestampArray.sorted(by: { $0.timestamp() > $1.timestamp() })
        
        self.timestampArray = sortedArray
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? SearchQueryViewController {
            controller.selectedTime = selectedTime
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timestampArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "\(timestampArray[indexPath.row].timestamp())"
        cell.detailTextLabel?.text = "\(timestampArray[indexPath.row].detail()!)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTime = timestampArray[indexPath.row].timestamp()
        _ = navigationController?.popViewController(animated: true)
    }

}
