//
//  ViewController.swift
//  demo
//
//  Created by zlywq on 14/12/31.
//  Copyright (c) 2014年 zlywq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var lblMsg: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func btnDialogDateTouched(sender: AnyObject) {
        var getResultBeforeHide: (NSDate)->Void = {
            [unowned self] (dt:NSDate) -> Void in
            self.lblMsg.text = "\(dt)"
        }
        
        var dlgDt = DialogDatePicker()
        dlgDt.init1Layout(self.view)
        dlgDt.init2Data(NSDate(), getResultBeforeHide: getResultBeforeHide)
        self.view.addSubview(dlgDt)
    }
    
    
    @IBAction func btnDialogMsgTouched(sender: AnyObject) {
        var getResultBeforeHide: (Bool)->Void = {
            [unowned self] (isOK:Bool) -> Void in
            self.lblMsg.text = "isOK=\(isOK)"
        }
        
        var msg = "中新社香港12月31日电 \n香港特别行政区政府食物及卫生局局长高永文31日早上就进口内地活鸡样本发现H7禽流感病毒会见传媒时表示，按照特区政府与内地有关部门就H7禽流感处置达成的共识，由于长沙湾临时家禽批发市场需要暂停运作21日，因此内地供港活鸡亦需要暂停。"
        
        var dlgDt = DialogAlert()
        dlgDt.init1Data(msg, getResultBeforeHide: getResultBeforeHide, needOKBtn: true, needCancelBtn: true)
        dlgDt.init2Layout(self.view)
        self.view.addSubview(dlgDt)
    }
    
    
    
    @IBAction func btnDialogListTouched(sender: AnyObject) {
        var getResultBeforeHide: (AnyObject)->Void = {
            [unowned self] (val:AnyObject) -> Void in
            self.lblMsg.text = "\(val)"
        }
        
        var dlg1 = DialogList_TowArray()
        dlg1.init1Layout(self.view)
        var itemsShow:[String] = [] //["aa","bb","cc"]
        var itemsVal:Array<AnyObject> = [] //[1,2,3]
        for(var i=0; i<20; i++){
            itemsShow.append("aasdf \(i)")
            itemsVal.append(i)
        }
        
        dlg1.init2Data(itemsShow, itemsValue:itemsVal, getResultBeforeHide: getResultBeforeHide)
        self.view.addSubview(dlg1)
    }
    
    
    @IBAction func btnDialogTreeTouched(sender: AnyObject) {
        var getResultBeforeHide: (AnyObject)->Void = {
            [unowned self] (val:AnyObject) -> Void in
            self.lblMsg.text = "\(val)"
        }
        
        var dlg1 = DialogList_LikeTree()
        dlg1.init1Layout(self.view)
        var items:[[String:AnyObject]] = []
        var keyName="name"
        var keyValue="value"
        var keyLevel="level"
        for(var i=0; i<20; i++){
            var item : [String:AnyObject] = [:]
            item[keyName] = "aasdf \(i)"
            item[keyValue] = i
            item[keyLevel] = i
            items.append(item)
        }
        
        dlg1.init2Data(items, keyName:keyName, keyValue:keyValue, keyLevel:keyLevel, getResultBeforeHide:getResultBeforeHide)
        self.view.addSubview(dlg1)
    }

    
    
    
    
    
    
    
    
    


}

