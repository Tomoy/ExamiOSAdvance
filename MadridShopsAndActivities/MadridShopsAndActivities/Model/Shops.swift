//
//  Shops.swift
//  MadridShops
//
//  Created by Tomás Ignacio Moyano on 9/7/17.
//  Copyright © 2017 Tomás Ignacio Moyano. All rights reserved.
//

import Foundation

public protocol ShopsProtocol {
    
    func count() -> Int
    func add(shop: Shop)
    func get(index: Int) -> Shop
}

public class Shops: ShopsProtocol {
    
    private var shopsList: [Shop]?
    
    public init() {
        shopsList = []
    }

    public func count() -> Int {
        return (shopsList?.count)!
    }
    
    public func add(shop: Shop) {
        shopsList?.append(shop)
    }
    
    public func get(index: Int) -> Shop {
        return shopsList![index]
    }
}
