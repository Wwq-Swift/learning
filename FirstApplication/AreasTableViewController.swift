//
//  AreasTableViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/15.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import CoreData

extension String{          //把汉字改为拼音
    func transformToPinYin() -> String{
        let ddd = NSMutableString(string: self)
        CFStringTransform(ddd, nil, kCFStringTransformToLatin, false)
        CFStringTransform(ddd, nil, kCFStringTransformStripDiacritics, false)               //去掉拼音的音标
        let string = String(ddd)
        return string.replacingOccurrences(of:" ", with: "")                                //去掉拼音之间的空格
    }}

class AreasTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    var areasDetail: [DatasMo] = []
    var fc: NSFetchedResultsController<DatasMo>!
    var seatchaResult: [DatasMo] = []
    var sc: UISearchController!
    
    
    func searchFilter(text: String) {
        seatchaResult = areasDetail.filter({ (Datas) -> Bool in
  //          let bbb = Datas.areasName as! CFMutableString
   //         let nnn = Zhuan(abc: bbb)
              return (Datas.areasName?.transformToPinYin().localizedCaseInsensitiveContains(text))!
      //      return (Datas.areasName?.localizedCaseInsensitiveContains(text))!
        })
    }
    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            searchFilter(text: text)
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        fetchAllData2()
        super.viewDidLoad()
        
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        tableView.tableHeaderView = sc.searchBar
        
        sc.searchBar.placeholder = "请输入景点名称..."
        sc.searchBar.searchBarStyle = .minimal
        
        sc.dimsBackgroundDuringPresentation = false
     
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       super.viewDidAppear(animated)
        
        
  //      fetchAllData()
   //     tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        if let object = controller.fetchedObjects {
            areasDetail = object as! [DatasMo]
        }
    }
    
    func fetchAllData2() {
        let request: NSFetchRequest<DatasMo> = DatasMo.fetchRequest()
        let sd = NSSortDescriptor(key: "areasName", ascending: true)
        request.sortDescriptors = [sd]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        
        do {
            try fc.performFetch()
            if let objects = fc.fetchedObjects {
                areasDetail = objects 
            }
            
        } catch {
            print(error)
        }
        
    }
 /*
    func fetchAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        do {
            areasDetail = try appDelegate.persistentContainer.viewContext.fetch(DatasMo.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
     //   return 0
  //  }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sc.isActive ? seatchaResult.count : areasDetail.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath) as! AreasTableViewCell
        
        let area = sc.isActive ? seatchaResult[indexPath.row] : areasDetail[indexPath.row]
        
        
        
        cell.direction.text = area.areas
        cell.areaName.text = area.areasName
        cell.areaDescribe.text = area.areasDescribe
        //      cell.loveImage.image = UIImage(data: detailvalue.areasImage as! Data)
        
        cell.areaImage.image = UIImage(data: area.areasImage as! Data)
        cell.areaImage.layer.cornerRadius = cell.areaImage.frame.size.height/2          //设置圆角半径
        cell.areaImage.clipsToBounds = true
        
        cell.accessoryType = area.judge ? .checkmark : .none //判断cell是不是为true
        
        //  cell.loveImage.isHidden = judge[indexPath.row]
        
        
        // Configure the cell...
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !sc.isActive
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Menu = UITableViewRowAction(style: .normal, title: "分享")
        { (_, indexPath) in
            let actionsheet = UIAlertController(title:"分享", message: nil, preferredStyle: .actionSheet)
            
            let wx = UIAlertAction(title: "微信", style: .default, handler: nil)
            let qq = UIAlertAction(title: "qq", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            actionsheet.addAction(wx)
            actionsheet.addAction(qq)
            actionsheet.addAction(cancel)
            
            self.present(actionsheet, animated: true, completion: nil)
            
        }
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            
      //      self.areasDetail.remove(at: indexPath.row)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
            
            // Delete the row from the data source
            
        //    tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [Menu,delete]
    }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {                                     //实现传值的功能
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detail" {
            let dest = segue.destination as! DetailTableViewController
            dest.areaDetail = sc.isActive ? seatchaResult[tableView.indexPathForSelectedRow!.row] : areasDetail[tableView.indexPathForSelectedRow!.row]
        }
    }

    
    
    
    
    @IBAction func returntoHome(segue: UIStoryboardSegue) {
        
    }

}
