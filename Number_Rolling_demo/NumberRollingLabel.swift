//
//  NumberRollingLabel.swift
//  Number_Rolling_demo
//
//  Created by Steven on 2022/9/18.
//

import UIKit

class NumberRollingLabel: UILabel {
    
    fileprivate var animationDuration = 2.0
    
    fileprivate var startingValue: Float = 0
    var destinationValue: Float = 50000
    fileprivate var progress: TimeInterval = 0
    fileprivate var lastUpdateTime: TimeInterval = 0
    fileprivate var totalTime: TimeInterval = 0
    
    fileprivate var timer: CADisplayLink?
    
    fileprivate var currentValue: Float {
        if progress >= totalTime { return destinationValue }
        return startingValue + Float(progress / totalTime) * (destinationValue - startingValue)
    }
    
    fileprivate func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(self.updateValue(timer:)))
        timer?.add(to: .main, forMode: .default)
    }
    
    @objc fileprivate func updateValue(timer: Timer) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdateTime
        lastUpdateTime = now
        
        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }
        
        setTextValue(value: currentValue)
    }
    
    fileprivate func setTextValue(value: Float) {
        text = String(format: "$ %.0f", value)
    }
}

extension NumberRollingLabel {
    func count(from: Float, to: Float, duration: TimeInterval? = nil) {
        startingValue = from
        destinationValue = to
        
        timer?.invalidate()
        timer = nil
        
        if duration == 0.0 {
            setTextValue(value: to)
            return
        }
        
        progress = 0.0
        totalTime = duration ?? animationDuration
        lastUpdateTime = Date.timeIntervalSinceReferenceDate
        
        addDisplayLink()
    }
    
    func countFromCurrent(to: Float, duration: TimeInterval? = nil) {
        count(from: currentValue, to: to, duration: duration ?? nil)
    }
}
