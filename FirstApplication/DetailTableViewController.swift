//
//  DetailTableViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import CoreData

class DetailTableViewController: UITableViewController {
    var areaDetail: DatasMo!
    
    @IBOutlet weak var dingwei: UIButton!
    @IBOutlet weak var pingjia: UIButton!
    
    @IBOutlet weak var bigImage: UIImageView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        bigImage.image = UIImage(data: areaDetail.areasImage as! Data)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        
        
        pingjia.layer.cornerRadius = 15
        dingwei.layer.cornerRadius = 15
        //设置圆角半径
        pingjia.clipsToBounds = true
        dingwei.clipsToBounds = true
        
        if let rating = areaDetail.rating {
            self.pingjia.setImage(UIImage(named: rating), for: .normal)
        }
 
  /*
        self.title = detailvalue.areas
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detailcell", for: indexPath) as! DetailTableViewCell
        cell.backgroundColor = UIColor.clear
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "景点名称"
            cell.valueLabel.text = areaDetail.areasName
        case 1:
            cell.fieldLabel.text = "景点位置"
            cell.valueLabel.text = areaDetail.areas
        case 2:
            cell.fieldLabel.text = "景点描述"
            cell.valueLabel.text = areaDetail.areasDescribe
        case 3:
            cell.fieldLabel.text = "去过与否"
            cell.valueLabel.text = areaDetail.judge ? "去过" : "没去过"
        default:
            break
        }
        
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
        if segue.identifier == "showMap" {
            let destVc = segue.destination as! MapViewController
            destVc.area = self.areaDetail
        }
        
        if segue.identifier == "show" {
            let dest = segue.destination as! PingJiaViewController
            dest.photo = areaDetail
        }

    }
   
    
    
    @IBAction func close(segue: UIStoryboardSegue) {                                            //取回转场的值
        let reviewVc = segue.source as! PingJiaViewController
        if let rating: String = reviewVc.rating {
            self.areaDetail.rating = reviewVc.rating!
            self.pingjia.setImage(UIImage(named: rating), for: .normal)
            
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        
    }


}
