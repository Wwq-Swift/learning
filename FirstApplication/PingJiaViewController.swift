//
//  PingJiaViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/16.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import CoreData


class PingJiaViewController: UIViewController {
    var photo: DatasMo?
    @IBOutlet weak var stackView: UIStackView!
    var rating: String?
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var fanhui: UIButton!
    
    @IBAction func pingjiaButtom(_ sender: UIButton) {
        
        switch sender.tag {
        case 101:
            rating = "dislike"
        case 102:
            rating = "good"
        case 103:
            rating = "great"
        default:
            break
        }
        performSegue(withIdentifier: "unwindToDetailView", sender: self)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        bigImageView.image = UIImage(data: photo?.areasImage as! Data)
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))      //图片虚化处理
        blurEffectView.frame = view.frame
        bigImageView.addSubview(blurEffectView)
        
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        let startPos = CGAffineTransform(translationX: 0, y: 500)
        
        stackView.transform = startScale.concatenating(startPos)     //图像动画
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        /*      UIView.animate(withDuration: 0.3) {
         self.ratingStackView.transform = CGAffineTransform.identity
         }*/  //另外一种效果
        
        let endScale = CGAffineTransform.identity
        let endPos = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.6, delay: 0.15, options: [], animations: {
            self.stackView.transform = endPos.concatenating(endScale)
        }, completion: nil)
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
