//
//  Random.swift
//  FlappyBirdClone
//
//  Created by Alex DeMars on 12/19/16.
//  Copyright © 2016 Alex DeMars. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
  
  public static func randomBetween(first: CGFloat, second: CGFloat) -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(first - second) + first
  }
  
}
