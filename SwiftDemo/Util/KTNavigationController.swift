//
//  KTNavigationController.swift
//  SwiftDemo
//
//  Created by Mac on 2019/11/1.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation
import UIKit

class KTNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate  {
    
    /** 是否开启全屏滑动返回功能（开启之后，则禁用系统边缘滑动返回） */
    var fullScreenPopGestureEnabled = true
    /** 是否取消滑动返回功能（取消之后，全屏滑动返回、系统边缘滑动返回 都将禁用） */
    var interactivePopDisable = false
    var popGestureDelegate:UIGestureRecognizerDelegate?
    var popPanGesture:UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        self.delegate = self
        let action = NSSelectorFromString("handleNavigationTransition:")
        popGestureDelegate = self.interactivePopGestureRecognizer?.delegate
        popPanGesture = UIPanGestureRecognizer.init(target: popGestureDelegate, action: action)
        popPanGesture!.maximumNumberOfTouches = 1;
        popPanGesture!.delegate = self;
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        viewControllers = [KTWrapViewController.wrapViewControllerWithViewController(viewController: rootViewController)]
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let isRootVC:Bool = viewController==navigationController.viewControllers.first
        if interactivePopDisable {
            self.view.removeGestureRecognizer(popPanGesture!)
            self.interactivePopGestureRecognizer?.delegate = self
            self.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            if fullScreenPopGestureEnabled {
                if isRootVC {
                    self.view.removeGestureRecognizer(popPanGesture!)
                } else {
                    self.view.addGestureRecognizer(popPanGesture!)
                }
                self.interactivePopGestureRecognizer?.delegate = popGestureDelegate
                self.interactivePopGestureRecognizer?.isEnabled = false
            } else {
                self.view.removeGestureRecognizer(popPanGesture!)
                self.interactivePopGestureRecognizer?.delegate = self
                self.interactivePopGestureRecognizer?.isEnabled = !isRootVC
            }
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = popPanGesture?.translation(in: self.view)
        if let x:CGFloat = point?.x, x<=0.0  {
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIScreenEdgePanGestureRecognizer
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
}

class KTWrapViewController: UIViewController {
    
    var rootViewController: UIViewController? {
        get {
            let nav = self.children.first
            let wraNav = nav as! KTNavigationController
            return wraNav.viewControllers.first
        }
    }
    
    override func viewDidLoad() {

    }
    
    fileprivate class func wrapViewControllerWithViewController(viewController: UIViewController) -> KTWrapViewController{
        let wrapNavigationController = KTWrapNavigationController()
        wrapNavigationController.view.backgroundColor = UIColor.white
        wrapNavigationController.viewControllers = [viewController]

        let wraViewController = KTWrapViewController()
        wraViewController.view.backgroundColor = UIColor.white
        wraViewController.view.addSubview(wrapNavigationController.view)
        wraViewController.addChild(wrapNavigationController)
        return wraViewController
    }
}

class KTWrapNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let button: UIButton = {
            let button = UIButton()
            button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 44)
            button.setImage(UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setImage(UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self,
                             action: #selector(click),
                             for: .touchUpInside)
            button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: -20, bottom: 0, right: 0)
            return button
        }()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
        let wraViewController = KTWrapViewController.wrapViewControllerWithViewController(viewController: viewController)
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(wraViewController, animated: animated)
    }
    
    @objc func click() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return self.navigationController?.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return self.navigationController?.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return self.navigationController?.popToViewController(viewController, animated: animated)
    }
}

