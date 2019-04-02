//
//  Model.swift
//  Calculation
//
//  Created by Nochnoy Anton on 29/03/2019.
//  Copyright © 2019 Nochnoy Anton. All rights reserved.
//

import Foundation
import Cocoa

struct Item {
    let label: CustomTextField
    let textField: CustomTextField?
    let number: Int
    
    init(title: String, number: Int, isFirst: Bool = false) {
        self.number = number
        
        label = isFirst
            ? CustomTextField(with: "\(number.translateToRomeNumber()). \(title)", font: 14,
                              textColor: NSColor(calibratedRed: 34/255, green: 138/255, blue: 23/255, alpha: 1))
            : CustomTextField(with: "\(number). \(title)", font: 12, textColor: .black)
        
        textField = isFirst
            ? nil
            : CustomTextField()
    }
    
    func readValue() -> String? {
        guard let textFd = self.textField else {
            return nil
        }
        
        if textFd.stringValue.isEmpty {
            textFd.selectText(nil)
        }
        
        //цикл для удаления лишних нулей в десятичной дроби
        while true {
            if textFd.stringValue.count == 1 {
                break
            }
            if textFd.stringValue.last == "0" {
                textFd.stringValue.removeLast()
                continue
            }
            break
        }
        
        if textFd.stringValue.last == "." {
            textFd.stringValue.removeLast()
        }
        
        return textFd.stringValue
    }
}


