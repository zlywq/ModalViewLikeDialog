//
//  DialogDatePicker.swift
//  tSwift1
//
//  Created by zlywq on 14/12/31.
//  Copyright (c) 2014年 zlywq. All rights reserved.
//

import Foundation
import UIKit

class DialogDatePicker : UIView {
    
    private var NeedBackgroundForDebug = false
    
    var backgroundColorForDialog = UIColor.blueColor()
    var colorForButtonText = UIColor.blackColor()

    
    var m_dtPicker : UIDatePicker? = nil
    var mBtnOK : UIButton? = nil
    var mBtnCancel : UIButton? = nil
    private var addedSubviews = false
    
    private var addedObserver_DeviceOrientationDidChange = false
    var getResultBeforeHide: ((dt:NSDate)->Void)? = nil
    //    var m_dt : NSDate!
    
    override init() {
        super.init()
        init1()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init1()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        init1()
//        doLayout(frame)
    }
    
    private func init1(){
        m_dtPicker = UIDatePicker()
//        self.addSubview(m_dtPicker!)
        
        mBtnOK = UIButton()
//        self.addSubview(mBtnOK!)
        mBtnOK!.setTitle("确定", forState: UIControlState.Normal)
        mBtnOK!.addTarget(self, action: "onBtnOKTouched:forEvent:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mBtnCancel = UIButton()
//        self.addSubview(mBtnCancel!)
        mBtnCancel!.setTitle("取消", forState: UIControlState.Normal)
        mBtnCancel!.addTarget(self, action: "onBtnCancelTouched:forEvent:", forControlEvents: UIControlEvents.TouchUpInside)


        //if ( is_IOS7()){
            if (!addedObserver_DeviceOrientationDidChange){
                addedObserver_DeviceOrientationDidChange = true
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDeviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
            }
        //}
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        doHide()
    }
    
    func onBtnOKTouched(sender:AnyObject! ,forEvent event:UIEvent!){
        if (getResultBeforeHide != nil){
            getResultBeforeHide!(dt: m_dtPicker!.date)
        }
        doHide()
    }
    func onBtnCancelTouched(sender:AnyObject! ,forEvent event:UIEvent!){
        doHide()
    }
    private func doHide(){
        self.removeFromSuperview()
        deinit1()
    }
    private func deinit1(){
        m_dtPicker = nil
        if (addedObserver_DeviceOrientationDidChange){
            addedObserver_DeviceOrientationDidChange = false
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    
    
    
    func init1Layout(parView:UIView){
        doLayout(parView)
    }
    func init2Data(dt:NSDate, getResultBeforeHide: ((dt:NSDate)->Void)?){
        m_dtPicker?.setDate(dt, animated: false)
        self.getResultBeforeHide = getResultBeforeHide
    }
    
    
    func doLayout(frame: CGRect){
        var boundsWhole = frame
        NSLog("DialogDatePicker.doLayout, boundsWhole=\(getDetail_CGRect(boundsWhole))")
        
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: boundsWhole.size)

        self.backgroundColor = backgroundColorForDialog
        

        var dtPicker : UIDatePicker = m_dtPicker!
        dtPicker.datePickerMode = UIDatePickerMode.DateAndTime
        if (NeedBackgroundForDebug){
            dtPicker.backgroundColor = UIColor.blueColor()
        }
        
        
        var centerX = boundsWhole.midX
        var centerY = boundsWhole.midY
        
        var sizeDtPicker = m_dtPicker!.sizeThatFits(CGSizeZero) //CGSize
        var originDtPicker = CGPoint(x: centerX-sizeDtPicker.width/2 , y: centerY-sizeDtPicker.height/2)
        var frameDtPicker = CGRect(origin: originDtPicker, size: sizeDtPicker)
        dtPicker.frame = frameDtPicker
        
        var margin : CGFloat = 10
        var btnW : CGFloat = 80
        var btnH : CGFloat = 40
        var btnSize = CGSize(width: btnW, height: btnH)
        var btnTop = frameDtPicker.maxY + margin
        var btnOKLeft = centerX/2 - btnW/2
        var btnCancelLeft = centerX * 3/2 - btnW/2
        mBtnOK?.frame = CGRect(origin: CGPoint(x: btnOKLeft, y: btnTop), size: btnSize)
        mBtnCancel?.frame = CGRect(origin: CGPoint(x: btnCancelLeft, y: btnTop), size: btnSize)
        
        mBtnOK?.setTitleColor(colorForButtonText, forState: UIControlState.Normal)
        mBtnCancel?.setTitleColor(colorForButtonText, forState: UIControlState.Normal)
        
        if (!addedSubviews){//添加后再修改多次frame而未刷新有显示问题
            addedSubviews = true
            self.addSubview(m_dtPicker!)
            self.addSubview(mBtnOK!)
            self.addSubview(mBtnCancel!)
        }
        
    }
    func doLayout(parView:UIView){
        var boundsPar = parView.bounds
        var framePar = parView.frame
        var boundsScreen = UIScreen.mainScreen().bounds
        var boundsWhole = boundsPar
        NSLog("DialogDatePicker.doLayout, boundsScreen=\(getDetail_CGRect(boundsScreen)) \n boundsPar=\(getDetail_CGRect(boundsPar)) \n framePar=\(getDetail_CGRect(framePar))")
        doLayout(boundsWhole)
    }
    
    
    
//    override func layoutSubviews() {
//        NSLog("ViewPop1.layoutSubviews")
//        doLayout(self.superview!)
//    }
    
    
    func onDeviceOrientationDidChange(notification:NSNotification!){
        NSLog("DialogDatePicker.onDeviceOrientationDidChange")
//        self.setNeedsLayout()
        doLayout(self.superview!)
    }
    
    
    
}