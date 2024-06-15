//
//  ChatViewModel.swift
//  GPT360
//
//  Created by Yaser on 13.06.2024.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let chatUseCase: ChatUseCase
    
    init(chatUseCase: ChatUseCase) {
        self.chatUseCase = chatUseCase
        loadMessages()
    }
    
    func sendMessage(_ text: String) {
        isLoading = true
        chatUseCase.fetchResponse(for: text)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    let errorMessage = Message(text: "Error: \(error.localizedDescription)", isUser: false)
                    self.messages.append(errorMessage)
                    self.saveMessages()
                }
            }, receiveValue: { [weak self] responseText in
                guard let self = self else { return }
                self.messages.append(Message(text: responseText, isUser: false))
                self.saveMessages()
            })
            .store(in: &cancellables)
    }
    
    func deleteAllMessages() {
        messages.removeAll()
        saveMessages()
    }
    
    private func saveMessages() {
        let messagesData = try? JSONEncoder().encode(messages)
        UserDefaults.standard.set(messagesData, forKey: PredefinedConstants.KeyIds.messagesKey)
    }
    
    private func loadMessages() {
        guard let messagesData = UserDefaults.standard.data(forKey: PredefinedConstants.KeyIds.messagesKey),
              let savedMessages = try? JSONDecoder().decode([Message].self, from: messagesData) else { return }
        print(savedMessages)
        messages = savedMessages
    }
    
}
