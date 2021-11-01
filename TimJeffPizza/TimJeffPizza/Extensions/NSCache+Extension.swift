//
//  NSCache+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 01/11/2021.
//

import Foundation

extension NSCache {
  @objc class var sharedInstance: NSCache<NSString, AnyObject> {
      let cache = NSCache<NSString, AnyObject>()
      return cache
  }
}
