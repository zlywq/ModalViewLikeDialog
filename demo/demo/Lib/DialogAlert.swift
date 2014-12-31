//
//  DialogAlert.swift
//  tSwift1
//
//  Created by zlywq on 14/12/31.
//  Copyright (c) 2014年 zlywq. All rights reserved.
//

import Foundation
import UIKit

class DialogAlert : UIView {
    
    private var NeedBackgroundForDebug = false
    
    var backgroundColorForDialog = UIColor.blueColor()
    var colorForButtonText = UIColor.blackColor()
    
    //var mMsg : String? = nil
    var mLblMsg : UILabel? = nil
    var mBtnOK : UIButton? = nil
    var mBtnCancel : UIButton? = nil
    private var addedSubviews = false
    var m_needOKBtn = true
    var m_needCancelBtn = true
    
    private var addedObserver_DeviceOrientationDidChange = false
    var getResultBeforeHide: ((isOk:Bool)->Void)? = nil
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
        mLblMsg = UILabel()
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
        if (getResultBeforeHide != nil){
            getResultBeforeHide!(isOk: false)
        }
        doHide()
    }
    
    func onBtnOKTouched(sender:AnyObject! ,forEvent event:UIEvent!){
        if (getResultBeforeHide != nil){
            getResultBeforeHide!(isOk: true)
        }
        doHide()
    }
    func onBtnCancelTouched(sender:AnyObject! ,forEvent event:UIEvent!){
        if (getResultBeforeHide != nil){
            getResultBeforeHide!(isOk: false)
        }
        doHide()
    }
    private func doHide(){
        self.removeFromSuperview()
        deinit1()
    }
    private func deinit1(){
        if (addedObserver_DeviceOrientationDidChange){
            addedObserver_DeviceOrientationDidChange = false
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    
    
    func init1Data(msg:String, getResultBeforeHide: ((Bool)->Void)?, needOKBtn:Bool, needCancelBtn:Bool){
        //mMsg = msg
        mLblMsg!.text = msg
        self.getResultBeforeHide = getResultBeforeHide
        m_needOKBtn = needOKBtn
        m_needCancelBtn = needCancelBtn
    }

    func init2Layout(parView:UIView){
        doLayout(parView)
    }
    
    
    func doLayout(frame: CGRect){
        var boundsWhole = frame
        NSLog("DialogAlert.doLayout, boundsWhole=\(getDetail_CGRect(boundsWhole))")
        
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: boundsWhole.size)
        
        self.backgroundColor = backgroundColorForDialog
        if (NeedBackgroundForDebug){
            mLblMsg!.backgroundColor = UIColor.blueColor()
        }
        
        
        var centerX = boundsWhole.midX
        var centerY = boundsWhole.midY
        
        mLblMsg!.numberOfLines = 0
        mLblMsg!.textAlignment = NSTextAlignment.Center
        
        var sizeLblMsg = CGSize(width: boundsWhole.width-40, height: CGFloat(Int.max))
        sizeLblMsg = mLblMsg!.sizeThatFits(sizeLblMsg) //CGSize
        var originLblMsg = CGPoint(x: centerX-sizeLblMsg.width/2 , y: centerY-sizeLblMsg.height/2-10)
        var frameLblMsg = CGRect(origin: originLblMsg, size: sizeLblMsg)
        mLblMsg!.frame = frameLblMsg
        
        var btnCnt = 0
        if (m_needOKBtn){
            btnCnt++
        }
        if (m_needCancelBtn){
            btnCnt++
        }
        
        var margin : CGFloat = 10
        var btnW : CGFloat = 80
        var btnH : CGFloat = 40
        var btnSize = CGSize(width: btnW, height: btnH)
        var btnTop = frameLblMsg.maxY + margin
        
        if (btnCnt == 2){
            var btnOKLeft = centerX/2 - btnW/2
            var btnCancelLeft = centerX * 3/2 - btnW/2
            mBtnOK?.frame = CGRect(origin: CGPoint(x: btnOKLeft, y: btnTop), size: btnSize)
            mBtnCancel?.frame = CGRect(origin: CGPoint(x: btnCancelLeft, y: btnTop), size: btnSize)
        }else if (btnCnt == 1){
            var btnLeft = centerX - btnW/2
            var btnFrame = CGRect(origin: CGPoint(x: btnLeft, y:btnTop), size:btnSize)
            if (m_needOKBtn){
                mBtnOK?.frame = btnFrame
            }
            if (m_needCancelBtn){
                mBtnCancel?.frame = btnFrame
            }
        }
        
        mBtnOK?.setTitleColor(colorForButtonText, forState: UIControlState.Normal)
        mBtnCancel?.setTitleColor(colorForButtonText, forState: UIControlState.Normal)
        
        if (!addedSubviews){//添加后再修改多次frame而未刷新有显示问题
            addedSubviews = true
            self.addSubview(mLblMsg!)
            if (m_needOKBtn){
                self.addSubview(mBtnOK!)
            }
            if (m_needCancelBtn){
                self.addSubview(mBtnCancel!)
            }
        }
        
    }
    func doLayout(parView:UIView){
        var boundsPar = parView.bounds
        var framePar = parView.frame
        var boundsScreen = UIScreen.mainScreen().bounds
        var boundsWhole = boundsPar
        NSLog("DialogAlert.doLayout, boundsScreen=\(getDetail_CGRect(boundsScreen)) \n boundsPar=\(getDetail_CGRect(boundsPar)) \n framePar=\(getDetail_CGRect(framePar))")
        doLayout(boundsWhole)
    }
    
    
    
    //    override func layoutSubviews() {
    //        NSLog("ViewPop1.layoutSubviews")
    //        doLayout(self.superview!)
    //    }
    
    
    func onDeviceOrientationDidChange(notification:NSNotification!){
        NSLog("DialogAlert.onDeviceOrientationDidChange")
        //        self.setNeedsLayout()
        doLayout(self.superview!)
    }
    
    
    
}