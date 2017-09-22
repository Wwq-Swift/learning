//
//  LivesTableViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/27.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import Just
import Kingfisher


class LivesTableViewController: UITableViewController {
    
    let livelistUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
    
    var list : [YKCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadList()
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = fals
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    func loadList() {
        // 强制转换类型 把json中live 转成livecell中的lives
        Just.post(livelistUrl) { (r) in
            guard let json = r.json as? NSDictionary else {
                return
            }
            
            let lives = YKLiveStream(fromDictionary: json).lives!
            self.list = lives.map({ (live) -> YKCell in
                return YKCell(portrait: live.creator.portrait, nick: live.creator.nick, location: live.city, viewers: live.onlineUsers, url: live.streamAddr)
            })
            dump(self.list)
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LivesTableViewCell
        
        let live = list[indexPath.row]
        
        cell.livAddr.text = live.location
        cell.labelNick.text = live.nick
        cell.labelViewers.text = "\(live.viewers)"
        
     //   let imgUrl = URL(string: "http://img2.inke.cn/" + live.portrait)
        let imgUrl = URL(string: live.portrait)

        
        cell.imgPor.kf.setImage(with: imgUrl)
        
        cell.imgBigPor.kf.setImage(with: imgUrl)

        // Configure the cell...
    

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let dest = segue.destination as! LivesViewController
        dest.live = list[(tableView.indexPathForSelectedRow?.row)!]
        
        
    }
    

}
