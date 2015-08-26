//
//  RichTextEditViewCtrl.swift
//  virtualspace_ios
//
//  Created by koujp on 15/7/18.
//  Copyright (c) 2015年 com.here.virtualspace. All rights reserved.
//

import Foundation
import UIKit

class RichTextEditViewCtrl:UIViewController{
    var mainView:UIView!;
    var webView:UIWebView!;
    let topHeight=CGFloat(HConstant.TOP_H);
    func initView(){
        var b=UIScreen.mainScreen().bounds;
        var height=b.height,width=b.width;
        webView=UIWebView();
        
        webView.frame=CGRectMake(0,0,width,height-topHeight);
        
        var url:NSURL?=NSURL(string:"http://172.18.0.100:63342/virtualspace_resource/app/app/story/html/demo.html");
        if let src=url{
            var urlRequest:NSURLRequest=NSURLRequest(URL:src);
           webView.loadRequest(urlRequest);
          
            
        }
        
        mainView = UIView(frame: CGRectMake(0, 0, width, height-topHeight));
        mainView.contentMode=UIViewContentMode.ScaleToFill;
        mainView.addSubview(webView)

        self.view.addSubview(mainView);
        
        
//        var btn:UIButton=UIButton(frame: CGRectMake(0, 0, 80, 30));
//        btn.setTitle("click", forState: UIControlState.Normal);
//        btn.addTarget(self, action: "btnClick", forControlEvents: UIControlEvents.TouchUpInside);
//        self.view.addSubview(btn);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyFrameChange:",  name: UIKeyboardWillShowNotification, object: nil);
        
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardHide:",  name: UIKeyboardWillHideNotification, object: nil);
        
    }
    func btnClick(){
        println("clicked")
        webView.resignFirstResponder();
        //webView.becomeFirstResponder();
    }
    func keyFrameChange(notification:NSNotification){
        
        
        var keyboardEndFrame:CGRect=CGRectZero;
        if let userInfo=notification.userInfo{
            
            keyboardEndFrame=userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue();
            
            println(keyboardEndFrame)
            
        }
        var b=UIScreen.mainScreen().bounds;
        var height=b.height,width=b.width;
        var keyH=keyboardEndFrame.height;
        var finalH=height-topHeight-keyH;
         webView.frame=CGRectMake(0,0,width,finalH);
        
    
    }
    func keyBoardHide(notification:NSNotification){
        var b=UIScreen.mainScreen().bounds;
        var height=b.height,width=b.width;
        webView.frame=CGRectMake(0,0,width,height-topHeight);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
        
    }

}
