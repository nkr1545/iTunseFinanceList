//
//  SegueHandler.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 11..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Segue
public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    public func performSegue(with segueIdentifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    public func segueIdentifier(with segue: UIStoryboardSegue) -> SegueIdentifier? {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            debugPrint("Couldn't handle segue identifier \(String(describing: segue.identifier)) for view controller of type \(type(of: self)).")
            return nil
        }
        return segueIdentifier
    }
}

