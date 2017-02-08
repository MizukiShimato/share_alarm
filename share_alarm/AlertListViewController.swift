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
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let time = alarm.time {
            cell.detailTextLabel?.text = dateFormatter.string(from: time)
        }
        return cell
    }
    
    //if let text2 = sender.text {
    //if let title = String(text2){
     //   alarm.title = title
    //"\(alarm.time)"
    //"\(alarm.time)")
    //"\([indexPath.row])個目のアラームです \(alarm.musicURL)"
    //"\([indexPath.row])個目のアラームです"

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
