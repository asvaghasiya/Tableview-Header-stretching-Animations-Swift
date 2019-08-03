//
//  ViewController.swift
//  StretchableTableViewHeader
//
//  Created by Romin Dhameliya on 06/06/19.
//  Copyright © 2019 Romin Dhameliya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var isOpenButton = 0
    var topView = TopView()
    var topViewSize:CGFloat = 318//Topview height
    var navigationHeight:CGFloat = 82//Headerview height
    var statusHeight = UIApplication.shared.statusBarFrame.size.height//Statusbar height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)![0] as! TopView
        view.frame = CGRect(x: 0, y: statusHeight, width: self.view.frame.width, height: self.view.frame.width)
        self.view.addSubview(view)
        topView = view
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: topViewSize, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = "\(indexPath.row+1). Music name."
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let y = topViewSize - (scrollView.contentOffset.y + topViewSize)
        let newHeaderViewHeight = topView.frame.height - scrollView.contentOffset.y
        
        if(y >= navigationHeight){
            if(y<=148 && y >= navigationHeight){
                let percent:Float = (Float((148-y) / y));
                topView.albumTopButton.alpha = CGFloat(percent)
            }else{
                topView.albumTopButton.alpha = 0
            }
            
            topView.albumTopButton.frame.origin.y = y
            
            if(isOpenButton == 1){
                isOpenButton = 0
                UIView.animate(withDuration: 0.1, animations: {
                    self.topView.btnAlbum.frame.origin.x = self.topView.btnAlbum.frame.origin.x + 5
                    self.topView.btnMusic.frame.origin.x = self.topView.btnMusic.frame.origin.x - 5
                }) { (Bool) in
                    self.shakeAnimation()
                }
            }
        }else{
            if(isOpenButton == 0){
                isOpenButton = 1
                UIView.animate(withDuration: 0.1, animations: {
                    self.topView.btnAlbum.frame.origin.x = self.topView.btnAlbum.frame.origin.x - 5
                    self.topView.btnMusic.frame.origin.x = self.topView.btnMusic.frame.origin.x + 5
                }) { (Bool) in
                    self.shakeAnimation()
                }
            }
            topView.albumTopButton.alpha = 1
            topView.albumTopButton.frame.origin.y = 100
        }
        
        let height = min(max(y, navigationHeight), 800)
        topView.frame = CGRect(x: 0, y: statusHeight, width: UIScreen.main.bounds.size.width, height: height)
        
        if(y >= topViewSize){
            topView.albumimage.transform = CGAffineTransform(scaleX: (y/topViewSize), y: (y/topViewSize))
            topView.albumTop.constant = 25
        }else{
            topView.albumTop.constant = (y-(topViewSize-25))+((y-topViewSize)*0.6)
        }
        
        if(y >= topViewSize){
            let final = ((450)-y) / ((450) - topViewSize)
            topView.albumButton.alpha = CGFloat(final)
        }else if (newHeaderViewHeight > topViewSize){
            let alphavalue = (newHeaderViewHeight/topViewSize) - 1
            topView.albumButton.alpha = CGFloat(alphavalue)
        }
    }
    
    func shakeAnimation(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: topView.btnAlbum.center.x - 2, y: topView.btnAlbum.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: topView.btnAlbum.center.x + 2, y: topView.btnAlbum.center.y))
        topView.btnAlbum.layer.add(animation, forKey: "position")
        
        let animation1 = CABasicAnimation(keyPath: "position")
        animation1.duration = 0.1
        animation1.repeatCount = 1
        animation1.autoreverses = true
        animation1.fromValue = NSValue(cgPoint: CGPoint(x: topView.btnMusic.center.x - 2, y: topView.btnMusic.center.y))
        animation1.toValue = NSValue(cgPoint: CGPoint(x: topView.btnMusic.center.x + 2, y: topView.btnMusic.center.y))
        topView.btnMusic.layer.add(animation1, forKey: "position")
    }
    
}
