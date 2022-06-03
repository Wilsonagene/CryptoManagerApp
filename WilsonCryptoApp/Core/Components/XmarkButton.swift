//
//  XmarkButton.swift
//  WilsonCryptoApp
//
//  Created by wilson agene on 6/3/22.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
//       let _ =  Self._printChanges()
       Button {
           presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
