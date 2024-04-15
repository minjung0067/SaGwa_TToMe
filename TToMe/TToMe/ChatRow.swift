//
//  ChatRow.swift
//  TToMe
//
//  Created by Minjung Lee on 4/15/24.
//

import SwiftUI

struct ChatRow: View {
    var body: some View {
        
        HStack{
            Image("profileimg")
                .resizable()
                .frame(width: 70, height:70)
                .clipShape(Circle())
            
            ZStack{
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("")
                    }
                }
            }
        }
    }
}

#Preview {
    ChatRow()
}
