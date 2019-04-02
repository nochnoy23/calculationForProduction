//
//  Extension.swift
//  Calculation
//
//  Created by Nochnoy Anton on 29/03/2019.
//  Copyright © 2019 Nochnoy Anton. All rights reserved.
//

import Cocoa

extension NSView {
    func profile(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    func addToCenter(for view: NSView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func add(views: [NSView]) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func add(subview: NSView, with anchors: [Anchor]) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            applyAnchor(anchor: anchor, view: subview)
        }
    }
    
    private func applyAnchor(anchor: Anchor, view: NSView) {
        switch anchor {
        case .leading:
            view.leadingAnchor.constraint(equalTo: view.superview!.leadingAnchor).isActive = true
        case .trailing:
            view.trailingAnchor.constraint(equalTo: view.superview!.trailingAnchor).isActive = true
        case .top:
            view.topAnchor.constraint(equalTo: view.superview!.topAnchor).isActive = true
        case .bottom:
            view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor).isActive = true
        }
    }
}

enum Anchor {
    case leading
    case trailing
    case top
    case bottom
}

extension NSButton {
    func setAttributes(foreground: NSColor? = nil, fontSize: CGFloat = -1.0, alignment: NSTextAlignment? = nil) {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let foreground = foreground {
            attributes[NSAttributedString.Key.foregroundColor] = foreground
        }
        
        if fontSize != -1 {
            attributes[NSAttributedString.Key.font] = NSFont.systemFont(ofSize: fontSize)
        }
        
        if let alignment = alignment {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = alignment
            attributes[NSAttributedString.Key.paragraphStyle] = paragraph
        }
        
        let attributed = NSAttributedString(string: self.title, attributes: attributes)
        
        self.attributedTitle = attributed
    }
}

extension Int {
    func translateToRomeNumber() -> String {
        let dictRomeNumber: [Int: String] = [1: "I", 2: "II", 3: "III", 4: "IV", 5: "V", 6: "VI"]
        guard let number = dictRomeNumber[self] else {
            return "X"
        }
        return number
    }
}
