//
//  ViewController.swift
//  Assesment_04
//
//  Created by  shawn on 09/01/2017.
//  Copyright © 2017 shawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cellArray = ["顯示一個AlertView","顯示藍色,點擊後變成紅色,再次點擊又會是藍色","透過CoreMotion 顯示使用者現在的步數,並且即時更新","開始此App在iOS設定的頁面","打開Google map App或是web導航至Alphacamp","開啟信箱並將標題填上測試信件"]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = myCollectionView.frame.width / 2
        //let picDimension = (self.view.frame.width / 2)-20
        //print("1",picDimension)
        print("2",dimension)
//        return CGSize(width: picDimension, height: picDimension)
        return CGSize(width: dimension, height: dimension)

        //  return CGSize(width: 200, height: 200)
        
//        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width /3, [UIScreen mainScreen].bounds.size.width /3);
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
            //print(indexPath.item)
        case 2:
            print("2")
            
        case 3:
            print("3")
        
        case 4:
            print("4")
        
        case 5:
            print("5")
        default:
            print("default")
        }
        
        
        
    }
    
    
}

