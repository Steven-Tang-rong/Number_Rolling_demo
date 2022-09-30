//
//  SwiftUIPreview.swift
//  Number_Rolling_demo
//
//  Created by Steven on 2022/9/19.
//

import SwiftUI

struct SwiftUIPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    typealias UIViewControllerType = ViewController
    
}

struct SwiftUIPreview_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIPreview()
            .previewLayout(.device)
            
    }
}
