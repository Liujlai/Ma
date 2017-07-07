//
//  ViewController.swift
//  地图搜索
//
//  Created by idea_liujl on 17/7/6.
//  Copyright © 2017年 idea_liujl. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    
    
    @IBOutlet weak var mapView: MKMapView!
//    初始化位置,使用地图经纬度搜索，确定经纬度
    let address = CLLocation(latitude: 28.6882457124, longitude: 115.8468767558)
//    设置搜索范围4公里
    let searchRadius:CLLocationDistance = 4000

    
    @IBOutlet weak var btnMenu: UIButton!
    @IBAction func btnMenuClick(sender: AnyObject) {
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            设置顺时针旋转方向
            self.btnMenu.transform = CGAffineTransformMakeRotation(0)
//            对3个按钮进行设置
            self.btnEY.alpha=0.8
            self.btnEY.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),CGAffineTransformMakeTranslation(-80, -25))
            self.btnLD.alpha=0.8
            self.btnLD.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),CGAffineTransformMakeTranslation(0, -50))
            self.btnCS.alpha=0.8
            self.btnCS.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5),CGAffineTransformMakeTranslation(80, -25))
            }, completion: nil)
    }
    
    @IBOutlet weak var btnEY: UIButton!
    
    @IBOutlet weak var btnLD: UIButton!
    
    @IBOutlet weak var btnCS: UIButton!
    
    @IBAction func btnEYClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("hospital")
        reselt()
    }
   
    @IBAction func btnLDClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("hotel")
        reselt()
    }
    
    @IBAction func btnCSClick(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap("supermarket")
        reselt()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.btnMenu.alpha = 0
        UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations:{() ->Void in
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransformMakeRotation(0.75*3.1415926)
            }, completion: nil)
        
        
        self.btnEY.alpha = 0
        self.btnLD.alpha = 0
        self.btnCS.alpha = 0
        self.btnEY.layer.cornerRadius = 10
        self.btnLD.layer.cornerRadius = 10
        self.btnCS.layer.cornerRadius = 10
        
        
//        创建一个区域
        let region = MKCoordinateRegionMakeWithDistance(address.coordinate, searchRadius, searchRadius)
//        设置显示
        mapView.setRegion(region, animated: true)
        searchMap("place")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func reselt(){
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //  设置顺时针旋转方向。3.1415926为圆周率的值，这里代表弧度：这里即为选装0.75＊360的弧度
            self.btnMenu.transform = CGAffineTransformMakeRotation(0.75*3.1415926)
            self.btnEY.alpha=0
            
//            CGAffineTransformMakeTranslation每次都是以最初位置的中心点为起始参照
//            CGAffineTransformMakeScale 缩放比例
            self.btnEY.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),CGAffineTransformMakeTranslation(0, 0))
            self.btnLD.alpha=0
            self.btnLD.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),CGAffineTransformMakeTranslation(0, 0))
            self.btnCS.alpha=0
            self.btnCS.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1),CGAffineTransformMakeTranslation(0, 0))
            }, completion: nil)
        
    }
//    添加兴趣点
    func addlocation(title : String,latitude:CLLocationDegrees,longtitude:CLLocationDegrees){
        let location = CLLocationCoordinate2D(latitude:latitude , longitude:longtitude)
        let annotation=MyAnn(coordinate: location, title: title)
        mapView.addAnnotation(annotation)
    }
//    搜索
    func searchMap(palce:String){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery=palce
//        搜索当前区域
        let span=MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center:address.coordinate, span: span)
//        启动搜索，并把返回结果保存在数组中
        let search=MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) -> Void in
            for item in response!.mapItems{
                self.addlocation(item.name!, latitude: (item.placemark.location?.coordinate.latitude)!, longtitude: (item.placemark.location?.coordinate.longitude)!)
            }
        }
        
    }
    
    
}

