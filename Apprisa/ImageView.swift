//
//  ImageView.swift
//  Apprisa
//
//  Created by Sergio Guerrero Olvera on 29/03/21.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        Image("BG").resizable().scaledToFit().scaledToFill()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
