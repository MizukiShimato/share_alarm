//
//  AlertListViewController.swift
//  share_alarm
//
//  Created by Mizuki Shimato on 2017-01-27.
//  Copyright © 2017 Mizuki Shimato. All rights reserved.
//

import UIKit

class AlertListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var alarms: [Alarm] = [Alarm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
        
        let instance = AlartFilebase()
        
        instance.get(userId: "mizuki") { fetchedAlarms in
            self.alarms = fetchedAlarms;
            self.tableView.reloadData()
        }

            alarms.append(initialAlarm())
    }
        // Do any additional setup after loading the view.

    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let alarm = alarms[indexPath.row]
        cell.textLabel?.text = alarm.title
        cell.detailTextLabel?.text = "\([indexPath.row])個目のアラームです \(alarm.musicURL)"
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
