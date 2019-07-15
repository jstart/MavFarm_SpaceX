//
//  ConvenienceExtensions.swift
//  MavFarm_SpaceX
//
//  Created by Truman, Christopher on 7/14/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit

let StandardDefaults = UserDefaults.standard
let DefaultNotification = NotificationCenter.default
let MainBundle = Bundle.main

extension UIAlertController {
    func addActions(_ actions: UIAlertAction...) { for action in actions { addAction(action) } }
    static func sheet(title: String? = nil, message: String? = nil) -> UIAlertController { return UIAlertController(title: title, message: message, preferredStyle: .actionSheet) }
    static func alert(title: String? = nil, message: String? = nil) -> UIAlertController { return UIAlertController(title: title, message: message, preferredStyle: .alert) }
}

extension UIAlertAction {
    convenience init(_ title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)? = nil) { self.init(title: title, style: style, handler: handler) }
    static func cancel(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction { return UIAlertAction("Cancel", style: .cancel, handler: handler) }
    static func ok(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction { return UIAlertAction("OK", style: .cancel, handler: handler) }
}

extension UIBarButtonItem {
    convenience init(_ image: UIImage, style: UIBarButtonItem.Style = .plain, target: AnyObject, action: Selector) { self.init(image: image, style: .plain, target: target, action: action) }
}

extension UITableView {
    func registerClass(_ cellClasses: AnyClass...) { for aClass in cellClasses { register(aClass, forCellReuseIdentifier: String(describing: aClass)) } }
    func registerNib(_ cellClasses: AnyClass...) { for aClass in cellClasses { let string = String(describing: aClass); register(UINib(nibName: string, bundle: nil), forCellReuseIdentifier: string) } }
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T { let string = String(describing: cellClass); return dequeueReusableCell(withIdentifier: string, for: indexPath) as! T }
}

extension UIStackView {
    convenience init(_ views: UIView..., axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0) { self.init(arrangedSubviews: views); self.axis = axis; self.spacing = spacing }
}

extension UserDefaults {
    subscript(key: String) -> Any? { return object(forKey: key) }
}
