//
//  File.swift
//  BaseLibrary
//
//  Created by DoHyoung Kim on 3/5/25.
//

import Foundation
import SwiftUI

extension View {
    
    public func onBottomSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: (() -> Content)) -> some View {
        modifier(AdaptiveSheetModifier(isPresented: isPresented, sheetContent: content))
    }
    
    public func onDialog<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: (() -> Content)) -> some View {
        modifier(DialogModifier(isPresented: isPresented, dialogContent: content))
    }
    
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    public func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder public func isHidden(_ hidden: Bool, remove: Bool = true) -> some View {
        if hidden {
            if remove {
                EmptyView()
            } else {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    public func transparentFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
    
    public func fontWithLineHeight(size: CGFloat, weight: Font.Weight, lineHeight: CGFloat) -> some View {
        self
            .font(.system(size: size, weight: weight))
            .lineSpacing((lineHeight - size) / 2)
            .padding(.vertical, (lineHeight - size) / 2)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct AdaptiveSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var sheetContent: SheetContent
    
    @State private var sheetHeight: CGFloat = 0
    
    init(isPresented: Binding<Bool>, sheetContent: () -> SheetContent) {
        self._isPresented = isPresented
        self.sheetContent = sheetContent()
    }
    
    func body(content: Content) -> some View {
        withAnimation(.linear(duration: 0.15)) {
            content
                .overlay {
                    if isPresented {
                        ZStack(alignment: .bottom) {
                            Color.black.opacity(0.5)
                                .onTapGesture {
                                    isPresented.toggle()
                                }
                            
                            sheetContent
                                .frame(maxWidth: .infinity)
                                .offset(y: isPresented ? 0 : -sheetHeight)
                                .background {
                                    GeometryReader { geometry in
                                        Color.clear
                                            .onAppear {
                                                sheetHeight = geometry.size.height
                                            }
                                    }
                                }
                        }
                    }
                }
        }
    }
}

struct DialogModifier<DialogContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var dialogContent: DialogContent
    
    init(isPresented: Binding<Bool>, dialogContent: () -> DialogContent) {
        self._isPresented = isPresented
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        withAnimation(.linear(duration: 0.15)) {
            content
                .overlay {
                    if isPresented {
                        ZStack {
                            Color.black.opacity(0.5)
                                .contentShape(Rectangle())
                                .allowsHitTesting(false)
                            
                            dialogContent
                        }
                        .zIndex(100)
                    }
                }
                .ignoresSafeArea(.all)
        }
    }
}

struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
