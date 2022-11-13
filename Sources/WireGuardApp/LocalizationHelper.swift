// SPDX-License-Identifier: MIT
// Copyright © 2018-2021 WireGuard LLC. All Rights Reserved.

import Foundation

public func tr(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

public func tr(format: String, _ arguments: CVarArg...) -> String {
    return String(format: NSLocalizedString(format, comment: ""), arguments: arguments)
}
