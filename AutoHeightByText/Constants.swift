//
//  Constants.swift
//  AutoHeightByText
//
//  Created by John Lima on 18/01/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import Foundation
import UIKit

enum FontName: String {
    case chalkboardSE = "Chalkboard SE"
}

struct Fonts {
    static let chalkboardSE = UIFont(name: FontName.chalkboardSE.rawValue, size: 17)
    static let chalkboardSEMinorSize = UIFont(name: FontName.chalkboardSE.rawValue, size: 13)
}

struct Colors {
    static let lightBlack = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
}
