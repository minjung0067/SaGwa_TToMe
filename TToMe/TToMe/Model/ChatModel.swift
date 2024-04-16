//
//  ChatModel.swift
//  TToMe
//
//  Created by Minjung Lee on 4/15/24.
//

import Foundation
import SwiftData

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
            Message("아 집가고싶다 ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 10))
        ]),
        Chat(person: Person(name: "Minjung2", imgString: "profileimg"), messages: [
            Message("배고파ㅏㅏㅇ라머;ㄴ이ㅏ럼;ㅣㅏㄴㅇ러ㅁㄴㅇ리ㅏㅓㅁ;ㄴ이ㅏ럼;ㅣㅏㄴ얼;ㅣ만얼;ㅣㅏㅁ넝ㄹ;ㅣㅏㅁ넝ㄹ;ㅣㅏ먼ㅇ;ㅣ라ㅓㅁㄴ;ㅣ아럼;니아러;미나얼;ㅣ만얼;ㅣㅏㅁㄴ얼;ㅣㅏㅁ넝ㄹ;ㅣㅏ먼ㅇㄹ;ㅣ만어리;마넝ㄹ;ㅣ마넝ㄹ;ㅣㅏ먼ㅇ;리ㅏ먼이;라ㅓㅁㄴㅇ;라ㅣㅁ넝리ㅏ먼ㅇ;리ㅏ먼;이ㅏㄹㅏㅏㅏ죽게네 ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 9))
        ]),
        Chat(person: Person(name: "Minjung3", imgString: "profileimg"), messages: [
            Message("왜이리하기가싫으냐 ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 8))
        ]),
        Chat(person: Person(name: "Minjung4", imgString: "profileimg"), messages: [
            Message("밤새기싫어ㅏ요 ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 7))
        ]),
        Chat(person: Person(name: "Minjung4", imgString: "profileimg"), messages: [
            Message("닭갈비먹곳ㅍ어용 ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 3))
        ]),
        Chat(person: Person(name: "Minjung4", imgString: "profileimg"), messages: [
            Message("드가자 ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2))
        ]),
        Chat(person: Person(name: "Minjung4", imgString: "profileimg"), messages: [
            Message("Hihi ", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1))
        ])
    ]
}
