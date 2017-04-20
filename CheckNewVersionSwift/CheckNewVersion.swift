//
//  CheckNewVersion.swift
//  CheckNewVersionSwift
//
//  Created by lalala on 2017/4/20.
//  Copyright © 2017年 lsh. All rights reserved.
//

import UIKit

class CheckNewVersion: NSObject {
    //单利
    static let shareSingleOne = CheckNewVersion()
    //闭包类型
    typealias swiftBlock = (_ str: AppleStoreModel) -> Void
    typealias swiftDicBlock = (_ str: NSDictionary) -> Void
    //懒加载
    lazy var infoDict:NSDictionary = {
        return Bundle.main.infoDictionary! as NSDictionary
    }()
    //显示在当前的viewcontroller上
    static func checkNewWithVersion(appId : String, controller: UIViewController) {
        shareSingleOne.checkNewVersionAppID(appId: appId, controller: controller)
    }
    //检查版本 返回给用户应用的数据 用户可以自定义弹出提示框
    static func checkNewVersionWithVersion(appID: String, checkNewBlock: @escaping swiftBlock) {
        shareSingleOne.getAppStoreVersion(appID: appID) { (model) in
            checkNewBlock(model)
        }
    }
    //检查版本号
   fileprivate func checkNewVersionAppID(appId : String, controller : UIViewController) {
        getAppStoreVersion(appID: appId) { (model) in
             let alertController = UIAlertController.init(title: model.version, message: model.releaseNotes, preferredStyle: .alert)
            let updateAction = UIAlertAction.init(title: "立即升级", style: .default, handler: { (action) in
                self.updateRightNow(model: model)
            })
            let delayAction = UIAlertAction.init(title: "稍后再说", style: .default, handler: { (action) in
            })
            let ignoreAction = UIAlertAction.init(title: "忽略", style: .default, handler: { (action) in
                self.ignoreNewVersion(version: model.version!)
            })
            alertController.addAction(updateAction)
            alertController.addAction(delayAction)
            alertController.addAction(ignoreAction)
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    //获取appstore版本信息
   fileprivate func getAppStoreVersion(appID: String, success: @escaping swiftBlock) {
        getAppStoreInfo(appId: appID){(resDict) in
            let resultCount = resDict.object(forKey: "resultCount") as! NSInteger
            if resultCount == 1 {
                let results = resDict.object(forKey: "results") as! NSArray
                let appStoreInfo = results.firstObject as! NSDictionary
                //字典转模型
                let model = AppleStoreModel.init()
                model.setValuesForKeys(appStoreInfo as! [String : Any])
                //提示是否更新
                let result = self.isEqualUpdate(newVersion: model.version!)
                if result == true {
                    success(model)
                }
            }
        }
    }
    //立即升级到最新版本
   fileprivate func updateRightNow(model : AppleStoreModel) {
        if UIApplication.shared.canOpenURL(URL.init(string: model.trackViewUrl!)!) {
            UIApplication.shared.open(URL.init(string: model.trackViewUrl!)!, options: [:], completionHandler: nil)
        }
    }
    //忽略新版本
   fileprivate func ignoreNewVersion(version : String) {
        //保存忽略的版本号
        UserDefaults.standard.set(version, forKey: "ingoreVersion")
        //同步到磁盘
        UserDefaults.standard.synchronize()
    }
    //返回是否提示更新
   fileprivate func isEqualUpdate(newVersion: String) -> Bool {
        let ignoreVersion = UserDefaults.standard.object(forKey: "ingoreVersion") as? String
        let versionString = infoDict.object(forKey: "CFBundleShortVersionString") as! String
        if versionString.compare(newVersion) == .orderedDescending || versionString.compare(newVersion) == .orderedSame || newVersion == ignoreVersion {
            return false
        } else {
            return true
        }
    }
    //获取App Store的info信息
   fileprivate func getAppStoreInfo(appId: String, success:  @escaping swiftDicBlock) {
        let url = URL.init(string: String.init(format: "https://itunes.apple.com/CN/lookup?id=%@", appId))!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                 //回到UI线程
                if JSONSerialization.isValidJSONObject(data!) {
                    print("不能转化")
                    return
                }
                if let result = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                    success(result as! NSDictionary)
                    print(result)
                }
            }
        }.resume()
    }
    
}
