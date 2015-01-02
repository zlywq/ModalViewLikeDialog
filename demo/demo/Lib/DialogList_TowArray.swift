//
//  DialogList_TowArray.swift
//  tSwift1
//
//  Created by zlywq on 15/1/2.
//  Copyright (c) 2015年 zlywq. All rights reserved.
//

import Foundation
import UIKit
class DialogList_TowArray : UIView , UITableViewDataSource, UITableViewDelegate {
    
    private var NeedBackgroundForDebug = false
    
    var backgroundColorForDialog = UIColor.blueColor()
    var colorForButtonText = UIColor.blackColor()
    
    
    var m_itemsShow : [String]? = nil
    var m_itemsValue : [AnyObject]? = nil
    
    
    
    var m_tableView : UITableView? = nil

    var mBtnCancel : UIButton? = nil
    private var addedSubviews = false
    
    private var addedObserver_DeviceOrientationDidChange = false
    var getResultBeforeHide: ((val:AnyObject)->Void)? = nil
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
        m_tableView = UITableView()
        m_tableView?.delegate = self
        m_tableView?.dataSource = self
        //        self.addSubview(m_dtPicker!)
        

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
    

    func onBtnCancelTouched(sender:AnyObject! ,forEvent event:UIEvent!){
        doHide()
    }
    private func doHide(){
        self.removeFromSuperview()
        deinit1()
    }
    private func deinit1(){
        m_tableView?.dataSource = nil
        m_tableView?.delegate = nil
        m_tableView = nil
        if (addedObserver_DeviceOrientationDidChange){
            addedObserver_DeviceOrientationDidChange = false
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    
    
    
    func init1Layout(parView:UIView){
        doLayout(parView)
    }
    func init2Data(itemsShow : [String]?, itemsValue : [AnyObject]?, getResultBeforeHide: ((val:AnyObject)->Void)?){

        m_itemsShow = itemsShow
        m_itemsValue = itemsValue
        self.getResultBeforeHide = getResultBeforeHide
    }
    
    
    func doLayout(frame: CGRect){
        var boundsWhole = frame
        NSLog("DialogList_TowArray.doLayout, boundsWhole=\(getDetail_CGRect(boundsWhole))")
        
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: boundsWhole.size)
        
        self.backgroundColor = backgroundColorForDialog
        
        
        var tableView = m_tableView!
        if (NeedBackgroundForDebug){
            tableView.backgroundColor = UIColor.blueColor()
        }
        
        var margin : CGFloat = 10
        var btnW : CGFloat = 80
        var btnH : CGFloat = 40
        var buttonBarHeight = margin + btnH + margin
        
        var centerX = boundsWhole.midX
        var centerY = boundsWhole.midY
        
        
//    iphone4s ios8.1 (iphone6)
//        shu need 20
//        heng only 0 , for no status bar
//    iphone4s ios7.1
//        shu need 20
//        heng need 20
//    ipad2 ios7.1
//        shu need 20
//        heng need 20
//    ipad2 ios8.1
//        shu need 20
//        heng only 0 , for no status bar
        var topBarHeight :CGFloat = 20
//        if (is_IOS8() && isDeviceOrientationLandscape() ){
//            topBarHeight = 0
//        }
        
        var sizeTableView = CGSize(width: boundsWhole.width, height: boundsWhole.height-buttonBarHeight-topBarHeight) //CGSize
        var originTableView = CGPoint(x: 0 , y: 0+topBarHeight)
        var frameTableView = CGRect(origin: originTableView, size: sizeTableView)
        tableView.frame = frameTableView
        
        
        var btnSize = CGSize(width: btnW, height: btnH)
        var btnTop = frameTableView.maxY + margin
        var btnCancelLeft = centerX - btnW/2
        mBtnCancel?.frame = CGRect(origin: CGPoint(x: btnCancelLeft, y: btnTop), size: btnSize)
        
        mBtnCancel?.setTitleColor(colorForButtonText, forState: UIControlState.Normal)
        
        if (!addedSubviews){//添加后再修改多次frame而未刷新有显示问题
            addedSubviews = true
            self.addSubview(tableView)
            self.addSubview(mBtnCancel!)
        }
        
    }
    func doLayout(parView:UIView){
        var boundsPar = parView.bounds
        var framePar = parView.frame
        var boundsScreen = UIScreen.mainScreen().bounds
        var boundsWhole = boundsPar
        NSLog("DialogList_TowArray.doLayout, boundsScreen=\(getDetail_CGRect(boundsScreen)) \n boundsPar=\(getDetail_CGRect(boundsPar)) \n framePar=\(getDetail_CGRect(framePar))")
        doLayout(boundsWhole)
    }
    
    
    

    
    
    func onDeviceOrientationDidChange(notification:NSNotification!){
        NSLog("DialogList_TowArray.onDeviceOrientationDidChange")
        doLayout(self.superview!)
    }
    
    
    
    
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cnt = 0;
        cnt = m_itemsShow==nil ? 0 : m_itemsShow!.count
        return cnt
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var CellIdentifier = "CellIdentifier1"
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        cell!.textLabel?.text = m_itemsShow?[indexPath.row]
        return cell!
    }
    
    //UITableViewDelegate
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
//        
//    }
//    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
//    {}
//    func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
//    {}
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if (getResultBeforeHide != nil){
            var val : AnyObject? = m_itemsShow?[indexPath.row]
            val = m_itemsValue==nil ? val : m_itemsValue![indexPath.row]
            getResultBeforeHide!(val: val!)
        }
        doHide()
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {}
    
//    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int // return 'depth' of row for hierarchies
//    {}
    
    
    
    
    
    
    
    
}