//
//  File.swift
//  BaseLibrary
//
//  Created by DoHyoung Kim on 3/5/25.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication {
    public var keyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first {
                $0.isKeyWindow
            }
    }
}

public struct safeAreaInsetKey: EnvironmentKey {
    public static var defaultValue: UIEdgeInsets {
        (UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    public var safeAreaInset: UIEdgeInsets {
        self[safeAreaInsetKey.self]
    }
}

extension UIEdgeInsets {
    public var insets: UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
