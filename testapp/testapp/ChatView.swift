//
//  ChatView.swift
//  testapp
//
//  Created by Elise Green on 2024-07-07.
//

import SwiftUI
import OpenAI


class ChatController: ObservableObject {
    @Published var messages: [Message] = []
    
    let openAI = OpenAI(apiToken: "key")
    
    func sendNewMessage(content: String) {
        let userMessage = Message(content: content, isUser: true)
        self.messages.append(userMessage)
        getBotReply()
    }
    
    func getBotReply() {
        let query = ChatQuery(
            messages: self.messages.map({
                .init(role: .user, content: $0.content)!
            }),
            model: .gpt3_5Turbo
        )
        
        openAI.chats(query: query) { result in
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                guard let message = choice.message.content?.string else { return }
                DispatchQueue.main.async {
                    self.messages.append(Message(content: message, isUser: false))
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

struct Message: Identifiable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}

struct ChatView: View {
    @StateObject var chatController: ChatController = .init()
    @State var string: String = ""
    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatController.messages) {
                    message in
                    MessageView(message: message)
                        .padding(5)
                        .id(message.id)
                }
            }
            Divider()
            HStack {
                TextField("Message...", text: self.$string, axis: .vertical)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(15)
                Button {
                    self.chatController.sendNewMessage(content: string)
                    string = ""
                } label: {
                    Image(systemName: "paperplane")
                }
            }
            .padding()
        }
        .background(
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
    

struct MessageView: View {
    var message: Message
    var body: some View {
        Group {
            if message.isUser {
                HStack {
                    Spacer()
                    Text(message.content)
                        .padding()
                        .background(Color("MessageColor")) // pink user message
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                        
                }
            } else {
                HStack {
                    Text("👩‍⚕️: " + message.content)
                        .padding()
                        .background(Color.white) // white chat message
                        .foregroundColor(Color("MessageColor")) // pink text
                        .cornerRadius(15)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

