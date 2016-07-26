//
//  SwiftLevelDB.swift
//  SwiftLevelDB
//
//  Created by Sedat Gökbek ÇİFTÇİ on 26/07/16.
//  Copyright © 2016 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import UIKit

public class SwiftLevelDB {
    var database: LevelDB!
    
    public init(databaseName: String) {
        database = LevelDB(databaseName: databaseName)
    }
    
    public subscript(key: String) -> AnyObject? {
        get {
            return database.getObject(key)
        }
        
        set(newValue) {
            setObject(newValue!, key: key)
        }
    }
    
    public func setObject(object: AnyObject?, key: String) {
        database.setObject(object, key: key)
    }
    
    public func getObject(key: String) -> AnyObject? {
        return database.getObject(key)
    }
    
    public func deleteObject(key: String) {
        database.deleteObject(key)
    }
    
    public func close() {
        database.close()
    }
}
