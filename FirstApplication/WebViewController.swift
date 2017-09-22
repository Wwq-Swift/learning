//
//  WebViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/18.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.isHidden = true
        let wkVwebview = WKWebView(frame: view.frame)
        view.addSubview(wkVwebview)
        
        wkVwebview.autoresizingMask = [.flexibleHeight]
        
        if let url = URL(string: "https://www.baidu.com") {
            let requeset = URLRequest(url: url)
            
            wkVwebview.load(requeset)
 //           webView.loadRequest(requeset)
        }

        // Do any additional setup after loading the view.
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
