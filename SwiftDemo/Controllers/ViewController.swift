//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/10.
//  Copyright © 2019 Ketil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {

    @IBOutlet weak var show: UIButton!
    @IBOutlet weak var hide: UIButton!
    var scroll = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.frame = self.view.frame
        scroll.backgroundColor = UIColor.clear
        scroll.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        self.view.insertSubview(scroll, belowSubview: show)
        
//        show.titleLabel?.font = UIFont.font(16, weight: 5)
//        hide.titleLabel?.font = UIFont.fontBold(20)
        show.titleLabel?.font = UIFont.font("PingFangSC-Semibold", size: 40*0.3)
        hide.titleLabel?.font = UIFont.font("aaaa", size: 40)

        self.scroll.headerRefresh {
//            [unowned self] in
//            print("headerRefresh ")
//            self.scroll.noticeNoMoreData()
        }
        self.scroll.footerRefresh {
            [unowned self] in
            print("footerRefresh ")
            self.scroll.noticeNoMoreData()
        }
        
//        BannerModel.getDatas { (result, error) in
//        }
//        UserModel.getDatas()
//        TotalModel.getDatas()
    }

    @IBAction func hudshow(_ sender: Any) {
        KTHud.show()
    }
    
    @IBAction func hudshowinf(_ sender: Any) {
        KTHud.showInfo("我是信息我是信息我是信息我是信息我是信息我是信息我是信息我是信息我是信息我是信息我是信息我是信息")
    }
    
    
    @IBAction func hudshowtopinfo(_ sender: Any) {
        KTHud.showTopInfo("我是TOP顶部信息")
    }
    
    @IBAction func hudhidden(_ sender: Any) {
        KTHud.hidden()
    }
}

