//
//  ChatsViewModel.swift
//  TToMe
//
//  Created by Minjung Lee on 4/16/24.
//

import Foundation


class ChatsViewModel: ObservableObject {
    @Published var chats = Chat.sampleChat
    
    func getSortedFilteredChats(query: String) -> [Chat] {
        let sortedChats = chats.sorted {
            guard let date1 = $0.messages.last?.date else {return false}
            guard let date2 = $1.messages.last?.date else {return false}
            return date1 > date2
        }
        
        if query == "" {
            return sortedChats
        }
        return sortedChats.filter { chat in chat.messages.contains { $0.text.lowercased().contains(query.lowercased()) }}
    }
    
    func sendMessage(_ text: String, in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            let message = Message(text, type: .Sent)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
}
