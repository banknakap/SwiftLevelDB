//
//  KVManager.swift
//  Example
//
//  Created by Sedat Gökbek ÇİFTÇİ on 26/07/16.
//  Copyright © 2016 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import UIKit
import SwiftLevelDB

public class KVManager: SwiftLevelDB {
    struct Static {
        static var onceToken: dispatch_once_t = 0
        static var instance: KVManager? = nil
    }
    
    public static var store: SwiftLevelDB {
        dispatch_once(&Static.onceToken) {
            Static.instance = KVManager()
        }
        
        return Static.instance!
    }
    
    public init() {
        super.init(storeName: "deneme")
    }
    
    override public func close() {
        super.close()
        Static.onceToken = 0
    }
    
}


