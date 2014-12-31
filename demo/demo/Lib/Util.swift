//
//  Util.swift
//  tBdMap
//
//  Created by zlywq on 14/11/28.
//  Copyright (c) 2014年 zlywq. All rights reserved.
//

import Foundation
import UIKit



func getDetail_CGPoint(p: CGPoint) -> String{
    var s1:String;
    s1 = "(\(p.x),\(p.y))"
    return s1;
}
func getDetail_CGSize(p: CGSize) -> String{
    var s1:String;
    s1 = "(\(p.width),\(p.height))"
    return s1;
}
func getDetail_CGRect(r: CGRect) -> String{
    var s1:String;
//    r.integerRect
    s1 = "("
    s1 += "origin=\(getDetail_CGPoint(r.origin)), wh=(\(r.width),height=\(r.height)), size=\(getDetail_CGSize(r.size))"
    s1 += ", minXY=(\(r.minX),\(r.minY)), maxXY=(\(r.maxX),\(r.maxY)), midXY=(\(r.midX),\(r.midY))"
    s1+=")"
    return s1;
}


func getDetail_UIView(v: UIView!) -> String{
    var s1:String = "";
    s1 = "(\n";
    s1 += "center=\(getDetail_CGPoint(v.center))";
    s1 += ", \nbounds=\(getDetail_CGRect(v.bounds)), \nframe=\(getDetail_CGRect(v.frame))";
    s1 += ", \naccessibilityFrame=\(getDetail_CGRect(v.accessibilityFrame)), \nintrinsicContentSize=\(getDetail_CGSize(v.intrinsicContentSize()))" ;
    s1 += ")";
    return s1;
}

