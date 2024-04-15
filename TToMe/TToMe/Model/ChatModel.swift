//
//  ChatModel.swift
//  TToMe
//
//  Created by Minjung Lee on 4/15/24.
//

import Foundation

struct Chat: Identifiable {
    var id: UUID {person.id}
    let person: Person
    var messages: [Message]
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let imgString: String
}

struct Message: Identifiable{
    
    enum MessageType {
        case Sent, Received
    }
    
    let id = UUID()
    let date: Date
    let text: String
    let type: MessageType
    
    init(_ text: String, type: MessageType, date: Date) {
        self.date = date
        self.type = type
        self.text = text
    }
    
    init(_ text: String, type: MessageType) {
        self.init(text, type: type, date: Date())
    }
}

extension Chat {
    static let sampleChat = [
        Chat(person: Person(name: "Minjung", imgString: "profileimg"), messages: [
            Message("Heyyy ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3))
        ])
    ]
}
