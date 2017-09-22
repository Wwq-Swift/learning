//
//  AddDataTableViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import CoreData

class AddDataTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var areasDetail: DatasMo!
    var isvisited: Bool = false

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var areadirection: UITextField!
    @IBOutlet weak var areaName: UITextField!
    @IBOutlet weak var areaDescribe: UITextField!
    @IBOutlet weak var comeHere: UILabel!
    @IBAction func comeHerButtom(_ sender: UIButton) {
        if sender.tag == 8001 {
            isvisited = true
            comeHere.text = "来过此景点"
        }else{
            isvisited = false
            comeHere.text = "未到此景点"
        }

    }
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        areasDetail = DatasMo(context: appDelegate.persistentContainer.viewContext)
        areasDetail.areas = areadirection.text
        areasDetail.areasName = areaName.text
        areasDetail.areasDescribe = areaDescribe.text
        areasDetail.judge = isvisited
        if let imageData = UIImageJPEGRepresentation(coverImage.image!, 0.7) {
            areasDetail.areasImage = NSData(data: imageData)
        }
        print("正在保存")
        
        appDelegate.saveContext()
        performSegue(withIdentifier: "unwindToHome", sender: self)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        coverImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        coverImage.contentMode = .scaleToFill
        coverImage.clipsToBounds = true
        
        dismiss(animated: true,completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("不可用")
                return
            }
            let picker = UIImagePickerController()
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            
            picker.delegate = self   //设置UInavigationcontrollerdelege 的代理
            
            self.present(picker, animated: true, completion: nil)
            
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    }
    

}
