//
//  MyAnn.swift
//  地图搜索
//
//  Created by idea_liujl on 17/7/6.
//  Copyright © 2017年 idea_liujl. All rights reserved.
//

import UIKit
import MapKit
class MyAnn: NSObject,MKAnnotation{
    var coordinate:CLLocationCoordinate2D=CLLocationCoordinate2DMake(0, 0)
    var title:String!
    init(coordinate:CLLocationCoordinate2D,title:String) {
        self.coordinate=coordinate
        self.title=title
    }
}
