//
//  JsonModel.swift
//
//  json 파일을 다룸
//
//  Created by Minjung Lee on 4/15/24.
//


import SwiftUI

class JsonModel: ObservableObject {
//    private var showingSimpleAlert = false
//    private var name = ""
    @Published var userData = [User]()
    @Published var chatData = [Chat]()
    
//    private var info: String = ""
    init() {
        fetchData()
    }
    
    // MARK: - json 파일 있는지 check
    func fetchData() {
        readUser(filename: "userData.json")
        readMessage(filename: "chatData.json")
    }

    // MARK: - userData.json 읽는 함수
    func readUser(filename: String) {
        var data: Data?
        var file: URL
        
        // get file directory
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        // get data
        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
        }
        
//        guard data != nil else { return }
        guard let data = data else { return }
        
        //decode data (convert data to model)
        do {
            let decoder = JSONDecoder()
            print("Reading...  📖: \(file.description)")
            userData = try decoder.decode([User].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([User].self):\n\(error)")
        }
    }
    // MARK: - chatData.json 읽는 함수
    func readMessage(filename: String) {
        var data: Data?
        var file: URL
        
        //get file directory
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        //get data
        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
        }
        
//        guard data != nil else { return }
        guard let data = data else { return }
        
        //decode data (convert data to model)
        do {
            let decoder = JSONDecoder()
            print("Reading...  📖: \(file.description)")
            chatData = try decoder.decode([Chat].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([Chat].self):\n\(error)")
        }
    }
    
    // MARK: - userData.json 쓰는 함수
    func writeUser(filename: String) {
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        // encode the array with new entry and write to JSON file
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            print("Writing...  📖: \(file.description)")
            try encoder.encode(userData).write(to: file)
        } catch {
            print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
        }
    }
    
    // MARK: - chatData.json 에 채팅 내역 쓰는 함수
    func writeChat(filename: String) {
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        // encode the array with new entry and write to JSON file
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            print("Writing...  📖: \(file.description)")
            try encoder.encode(chatData).write(to: file)
        } catch {
            print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
        }
    }
    // MARK: - 채팅 정렬 + filter를 사용한 검색 기능
    func getSortedFilteredChats(query: String) -> [JsonModel.Chat] {
        // 날짜로 정렬
        let sortedChats = chatData.sorted {
//            guard let date1 = $0.writtenAt else {return false}
//            guard let date2 = $1.writtenAt else {return false}
            guard $0.writtenAt != $1.writtenAt else { return false }
            return $0.writtenAt > $1.writtenAt
        }
        
        if query == "" {
            return sortedChats
        }
        return sortedChats.filter { chat in
            // filter 기능으로 채팅 검색
            chat.msg.lowercased().contains(query.lowercased())
            
        }
    }
    // MARK: - 전송 버튼 눌렀을 때 호출되는 함수
    func sendMessage(_ text: String) {
        //guard !text.isEmpty else { return }
//        if text.isEmpty { return }
        chatData.append(JsonModel.Chat(msg: text, writtenAt: .now))
        writeChat(filename: "chatData.json")
    }
    // MARK: - MessageTimeView에서 버튼 눌렀을 때 호출되는 함수
    func saveUser(_ name: String, _ messageTime: Date) {
        //guard !text.isEmpty else { return }
//        if text.isEmpty { return }
        userData.append(JsonModel.User(name: name, messageTime: messageTime))
        writeUser(filename: "userData.json")
    }
    // saveUser(name, time)
    // saveUser(name: name, time: time)
    
    
    // MARK: - User 구조체
    struct User: Codable, Identifiable {
        var id: UUID = UUID()
        var name: String
        var messageTime: Date
    }
    
    // MARK: - Chat 구조체
    struct Chat: Codable, Identifiable {
        var id: UUID = UUID()
        var msg: String
        var writtenAt: Date
    }
    
}
