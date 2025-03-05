//
//  File.swift
//  BaseLibrary
//
//  Created by DoHyoung Kim on 3/5/25.
//

import Foundation
import SwiftUI

extension Date {
    func getHourMinSecGap(serverTime: String, isFrom: Bool, addingFiveMin: Bool = false) -> String {
        var offsetComp: DateComponents = DateComponents()
        if isFrom {
            offsetComp = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: Date())
        } else {
            offsetComp = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: self)
        }
        
        var hour = ""
        var minute = ""
        var second = ""
        
        if let hourInt = offsetComp.hour {
            if hourInt < 10 {
                if hourInt <= 0 {
                    hour = "00"
                } else {
                    hour = "0\(hourInt)"
                }
            } else {
                hour = "\(hourInt)"
            }
        }
        
        if let minuteInt = offsetComp.minute {
            var addingMinute = minuteInt
            
            if addingFiveMin {
                addingMinute += 5
            }
            
            if addingMinute < 10 {
                if addingMinute <= 0 {
                    minute = "00"
                } else {
                    minute = "0\(addingMinute)"
                }
            } else {
                minute = "\(addingMinute)"
            }
        }
        
        if let secInt = offsetComp.second {
            if secInt < 10 {
                if secInt <= 0 {
                    second = "00"
                } else {
                    second = "0\(secInt)"
                }
            } else {
                second = "\(secInt)"
            }
        }
        
        return "\(hour):\(minute):\(second)"
    }
    
    //MARK: 몇시간 전, 몇초 전 등 얼마 전이라고 표현하고 싶을때 사용 ago
    func relativeFormat() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func convertFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
