
import SwiftUI

struct JsonModel: View {
    @State private var showingSimpleAlert = false
    @State private var name = "ss"
    @State private var userData = [User]()
    @State private var chatData = [Chat]()
    
    @State private var info: String = ""
    var body: some View {
        Text(info)
            .onAppear {
                onAppear()
            }

    }
    
    func onAppear() {
        userData = readUser(filename: "userData.json") ?? []
        chatData = readMessage(filename: "chatData.json") ?? []
        let countOfUsersBeforeWriting = userData.count
        let countOfChatsBeforeWriting = chatData.count
        userData = [
            .init(uid: UUID(), name: "Josh", messageTime: Date()),
            .init(uid: UUID(), name: "Katy", messageTime: Date()),
            .init(uid: UUID(), name: "Logan", messageTime: Date()),
            .init(uid: UUID(), name: "Miguel", messageTime: Date())
        ]
        chatData = [
            .init(mid: UUID(), msg: "1번 ", writtenAt: Date.now),
            .init(mid: UUID(), msg: "2번", writtenAt: Date.now),
            .init(mid: UUID(), msg: "3번", writtenAt: Date.now),
        ]
        
        writeUser(array: userData, filename: "userData.json")
        writeChat(array: chatData, filename: "chatData.json")
        userData = readUser(filename: "userData.json") ?? []
        chatData = readUser(filename: "chatData.json") ?? []
        info = """
        Before writing:
        Total # of users: \(countOfUsersBeforeWriting)
        Total # of users: \(countOfChatsBeforeWriting)
        After writing:
        Total # of users: \(userData[0])
        Total # of users: \(chatData[0].msg)
        """
    }
    
    // Read data from JSON
    func readUser<T: Codable>(filename: String) -> T? {
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
        
        guard data != nil else { return nil }
        
        //decode data (convert data to model)
        do {
            let decoder = JSONDecoder()
            print("Reading...  📖: \(file.description)")
            return try decoder.decode(T.self, from: data!)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    // Read data from JSON
    func readMessage<T: Codable>(filename: String) -> T? {
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
        
        guard data != nil else { return nil }
        
        //decode data (convert data to model)
        do {
            let decoder = JSONDecoder()
            print("Reading...  📖: \(file.description)")
            return try decoder.decode(T.self, from: data!)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    
    // Write data to JSON
    func writeUser<T: Codable>(array: [T], filename: String) {
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
            try encoder.encode(array).write(to: file)
        } catch {
            print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
        }
    }
    
    // Write data to JSON
    func writeChat<T: Codable>(array: [T], filename: String) {
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
            try encoder.encode(array).write(to: file)
        } catch {
            print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
        }
    }
    
    struct User: Codable {
        var uid: UUID
        var name: String
        var messageTime: Date
    }
    
    struct Chat: Codable {
        var mid: UUID
        var msg: String
        var writtenAt: Date
    }
    
}

struct JsonModel_Preview: PreviewProvider {
    static var previews: some View {
        JsonTestModel()
    }
}
