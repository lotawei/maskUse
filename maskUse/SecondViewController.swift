//
//  SecondViewController.swift
//  maskUse
//
//  Created by lotawei on 16/9/23.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
   //1.创建图层
    var movedMask:CALayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        emitterMask()
        
        
        // Do any additional setup after loading the view.
    }
    
    func emitterMask() {
    //2.创建粒子layer
        let snowEmitter: CAEmitterLayer = CAEmitterLayer()

        //3.  粒子发射位置
          snowEmitter.emitterPosition = CGPoint(x: 120, y: 0)
        // 发射源的尺寸大小
          snowEmitter.emitterSize = emitersize
        // 发射模式
        snowEmitter.emitterMode = kCAEmitterLayerSurface
        // 发射源的形状
        snowEmitter.emitterShape = kCAEmitterLayerLine
        // 创建雪花类型的粒子
        let snowFlake: CAEmitterCell = CAEmitterCell()
        
        // 粒子的名字
        snowFlake.name = "snow"
        
        // 粒子参数的速度乘数因子
        snowFlake.birthRate = 15
        snowFlake.lifetime  = 60
        
        // 粒子速度
        snowFlake.velocity = 10
        
        // 粒子的速度范围
        snowFlake.velocityRange = 10
        
        // 粒子y方向的加速度分量
        snowFlake.yAcceleration = 20
        
        // 周围发射角度
        snowFlake.emissionRange = CGFloat(0.5 * M_PI)
        
        // 子旋转角度范围
        snowFlake.spinRange = CGFloat(0.25 * M_PI)
        snowFlake.contents  = UIImage(named: "雪花")?.cgImage
        
        // 设置雪花形状粒子的颜色
        snowFlake.color = UIColor.white.cgColor
        
        snowFlake.scale      = 0.2
        snowFlake.scaleRange = 0.2
        
        snowEmitter.shadowOpacity = 1
        snowEmitter.shadowRadius  = 0
        snowEmitter.shadowOffset  = CGSize.zero
        
        // 粒子边缘的颜色
        snowEmitter.shadowColor = UIColor.white.cgColor
        
        // 添加粒子
        snowEmitter.emitterCells = [snowFlake]
        
        // 将粒子layer添加进图层
        view.layer.addSublayer(snowEmitter)
        
        //4.准备遮罩
        // 形成遮罩
        let maskImage: UIImage = UIImage(named: "遮罩副本")!
        movedMask = CALayer()
        movedMask?.frame = CGRect(origin: maskorgpoint, size: maskImage.size)
        movedMask?.contents = maskImage.cgImage
        movedMask?.position = view.center
        snowEmitter.mask = movedMask
        
        // 5.拖拽的view
        let dragView: UIView = UIView(frame: CGRect(origin: maskorgpoint, size: maskImage.size))
        dragView.center = view.center
        view.addSubview(dragView)
        // 6.给dragView添加拖拽手势
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SecondViewController.handlePan(recongnizer:)))
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
