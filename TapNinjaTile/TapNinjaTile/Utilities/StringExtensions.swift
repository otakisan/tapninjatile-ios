//
//  StringExtensions.swift
//  TapNinjaTile
//
//  Created by takashi on 2016/04/30.
//  Copyright © 2016年 Takashi Ikeda. All rights reserved.
///
import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(args : [CVarArgType]) -> String {
        return String(format: self.localized(), arguments: args)
    }
}
