//
//  AppleStoreModel.swift
//  CheckNewVersionSwift
//
//  Created by lalala on 2017/4/20.
//  Copyright © 2017年 lsh. All rights reserved.
//

import UIKit

class AppleStoreModel: NSObject {
    //版本号
    var version:String?
    //更新日志
    var releaseNotes:String?
//    //更新时间
//    var currentVersionReleaseDate:String?
//    //appID
//    var trackId:String?
//    //bundleID
//    var bundleId:String?
//    //appstore地址
    var trackViewUrl:String?
//    //开发商
//    var sellerName:String?
//    //文件大小
//    var fileSizeBytes:String?
//    //展示图
    var screenshotUrls:NSArray?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
