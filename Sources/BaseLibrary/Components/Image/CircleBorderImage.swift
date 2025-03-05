//
//  File.swift
//  BaseLibrary
//
//  Created by DoHyoung Kim on 3/5/25.
//

import Foundation
import SwiftUI

struct CircleBorderImage: View {
    let inset: CGFloat
    let image: Image
    let borderColor: Color
    let lineWidth: CGFloat
    
    init(inset: CGFloat, image: Image, borderColor: Color, lineWidth: CGFloat? = nil) {
        self.inset = inset
        self.image = image
        self.borderColor = borderColor
        if let width = lineWidth {
            self.lineWidth = width
        } else {
            self.lineWidth = inset
        }
    }
    
    var body: some View {
        Circle()
            .inset(by: inset)
            .strokeBorder(borderColor, lineWidth: lineWidth)
            .background {
                image
                    .resizable()
            }
            .clipShape(Circle())
    }
}
