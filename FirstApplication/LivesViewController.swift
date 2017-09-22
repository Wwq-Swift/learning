//
//  LivesViewController.swift
//  FirstApplication
//
//  Created by 王伟奇 on 17/3/28.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit

class LivesViewController: UIViewController {
    var live: YKCell!
    var playerView: UIView!
    var ijkPlayer: IJKMediaPlayback!

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnGift: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBAction func tapBack(_ sender: Any) {
        ijkPlayer.shutdown()
        
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func tapGift(_ sender: Any) {
        let herat = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        herat.center = CGPoint(x: btnLike.frame.origin.x, y: btnLike.frame.origin.y)
        view.addSubview(herat)
        herat.animate(in: view)
        
        //爱心按钮大小的关键帧动画
        let btnAnime = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnime.values = [1.0, 0.7, 0.5, 0.3, 0.5, 0.7, 1.0, 1.2, 1.4, 1.2,1.0]
        btnAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
        btnAnime.duration = 0.2
        (sender as AnyObject).layer.add(btnAnime, forKey: "SHOW")
        
    }
    @IBAction func tapGifts(_ sender: Any) {
        let duration = 3.0
        let car = UIImageView(image: #imageLiteral(resourceName: "porsche"))
        
        car.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(car)
        
        let widthCar: CGFloat = 250
        let heightCar: CGFloat = 125
        
        UIView.animate(withDuration: duration) {
            car.frame = CGRect(x: self.view.center.x - widthCar/2, y: self.view.center.y - heightCar/2, width: widthCar, height: heightCar)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { 
            UIView.animate(withDuration: duration, animations: { 
                car.alpha = 0
            }, completion: { (completed) in
                car.removeFromSuperview()
            })
        }
        
        let layerFw = CAEmitterLayer()
        view.layer.addSublayer(layerFw)
        emmitParticles(from: (sender as AnyObject).center, emitter: layerFw, in: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) { 
            layerFw.removeFromSuperlayer()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(live)
        setBg()
        setPlayerView()
        bringBtnToFront()
        

        // Do any additional setup after loading the view.
    }
    
    func setPlayerView() {
        //设置视频的框架
        self.playerView = UIView(frame: view.bounds)
        view.addSubview(self.playerView)
        
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: live.url, with: nil)
        let pv = ijkPlayer.view!
        
        pv.frame = playerView.bounds
        pv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView.insertSubview(pv, at: 2)
        ijkPlayer.scalingMode = .aspectFill
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.ijkPlayer.isPlaying() {
            ijkPlayer.prepareToPlay()
        }
    }
    
    
    func setBg() {
        let imgUrl = URL(string: live.portrait)
        imgBack.kf.setImage(with: imgUrl)
        
    }
    func bringBtnToFront() {
        view.bringSubview(toFront: btnBack)
        view.bringSubview(toFront: btnGift)
        view.bringSubview(toFront: btnLike)
        
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
