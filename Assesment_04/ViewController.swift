//
//  ViewController.swift
//  Assesment_04
//
//  Created by  shawn on 09/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit
import CoreMotion //計算步數用
import MessageUI //開啟mail用
import NotificationCenter

class ViewController: UIViewController {
    
    typealias CMPedometerHandler = (CMPedometerData?, Error?) -> Void

    @IBOutlet weak var labelForStepCounter: UILabel!
    var cellArray = ["顯示一個AlertView","顯示藍色,點擊後變成紅色,再次點擊又會是藍色","透過CoreMotion 顯示使用者現在的步數,點擊後開始即時更新","開始此App在iOS設定的頁面","打開Google map App或是web導航至Alphacamp","開啟信箱並將標題填上測試信件"]
    let activityManager = CMMotionActivityManager()
    //var motionManager = CMMotionManager()
    let pedoMeter = CMPedometer()
    let date = Date()
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    
        //如果方向轉變,就要重新調整CollectionViewCell的大小
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewReload), name: .UIDeviceOrientationDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewReload(){
        print("重新載入collectionView的大小")
        myCollectionView.reloadData()
    }
    
    func updateStepCounter(){
        print("計步數process")
        if CMPedometer.isStepCountingAvailable(){
            print("計步中")
        self.pedoMeter.startUpdates(from: self.date , withHandler: {
            (data , error) -> Void in
            print(data)
            print(error)
            DispatchQueue.main.async {
                (self.myCollectionView.cellForItem(at: [0,2]) as! CustomCollectionViewCell).labelForCellText.text = "\(data?.numberOfSteps)"
                print("計步數：\(data?.numberOfSteps)")
            }
        })
        }else{
             (self.myCollectionView.cellForItem(at: [0,2]) as! CustomCollectionViewCell).labelForCellText.text = "該裝置不支援計步數"
        }
    }

}


extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cell.labelForCellText.text = cellArray[indexPath.row]
        cell.labelForCellText.backgroundColor = UIColor.clear
        //label會歪掉,需再次autolayout一次,但是原本的autolayout還是要設定
        let horizontalConstraint = cell.labelForCellText.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        let verticalConstraint = cell.labelForCellText.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint,verticalConstraint])
        print("---->",cell.labelForCellText.frame)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = myCollectionView.frame.width / 2
        print("cell寬度",dimension)
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            print("顯示alert")
            let alert = UIAlertController(title: "歡迎", message: "歡迎光臨", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        case 1:
            print("更換顏色")
            if collectionView.cellForItem(at: indexPath)?.backgroundColor == UIColor.blue{
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.red
            }else{
                collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.blue
            }
        case 2:
            print("2")
            print(indexPath)
            self.updateStepCounter()
            
        case 3:
            print("3")
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString) as! URL
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        case 4:
            print("4")
           if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)){
                UIApplication.shared.open(NSURL(string:
                    "comgooglemaps-x-callback://?saddr=&daddr=25.052532,121.532302&directionsmode=driving")! as URL)
            } else {
                print("Can't use comgooglemaps://")
            }
        case 5:
            print("5")
            let mailController = MFMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail() {
                mailController.setSubject("測試信件")
                mailController.setToRecipients(["123@123.com"])
                mailController.setMessageBody("Test message body", isHTML: false)
                mailController.mailComposeDelegate = self
            }
                self.present(mailController, animated: true, completion: nil)
        default:
            print("default")
        }
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}

