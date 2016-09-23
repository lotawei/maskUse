//
//  ViewController.swift
//  maskUse
//
//  Created by lotawei on 16/9/23.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    //1. 使用一个图层
    
    var movedMask:CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view, typically from a nib.
        mask()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func   mask(){
        
          // 2.背景图片与mask图片
          let backgroundImage: UIImage = UIImage(named: "背景图菊花")!
        let maskImage:       UIImage = UIImage(named: "遮罩副本")!
       //3.显示图片背景
        let backgroundIV: UIImageView = UIImageView(frame: imgfrm)
        backgroundIV.image = backgroundImage.grayScale()
        view.addSubview(backgroundIV)
        
        //4.遮罩图片显示
        let backgroundChangedIV: UIImageView = UIImageView(frame: imgfrm)
        backgroundChangedIV.image = backgroundImage
        view.addSubview(backgroundChangedIV)
        
        //5.形成遮罩
       
        movedMask = CALayer()
        movedMask?.frame = CGRect(origin:maskorgpoint, size: maskImage.size)
        movedMask?.contents = maskImage.cgImage
        movedMask?.position = view.center
        backgroundChangedIV.layer.mask = movedMask
        //6.拖拽的view
        let dragView: UIView = UIView(frame: CGRect(origin: maskorgpoint, size: maskImage.size))
        dragView.center = view.center
        view.addSubview(dragView)
        // 7.给dragView添加拖拽手势
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(recongnizer:)))
        dragView.addGestureRecognizer(pan)

        

    }
    
    func handlePan(recongnizer: UIPanGestureRecognizer) {
        
       
        let translation: CGPoint = recongnizer.translation(in: view)
        recongnizer.view?.center = CGPoint(x: (recongnizer.view?.center.x)! + translation.x, y: (recongnizer.view?.center.y)! + translation.y)
        recongnizer.setTranslation(CGPoint(x: 0, y: 0), in: view)
        
        // 关闭CoreAnimation实时隐式动画绘制(核心)
        CATransaction.setDisableActions(true)
        movedMask?.position = (recongnizer.view?.center)!
    }
    


}

