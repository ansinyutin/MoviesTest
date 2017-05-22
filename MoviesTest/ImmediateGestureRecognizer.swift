//
//  ImmediateGestureRecognizer.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 15.05.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class ImmediatePanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) {
            return
        }
        super.touchesBegan(touches, with: event)
        self.state = .began;
    }
}
