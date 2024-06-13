//
//  OpenAIService.swift
//  GPT360
//
//  Created by Yaser on 13.06.2024.
//

import Foundation
import Combine
import OpenAI

protocol OpenAIServiceProtocol {
    func fetchResponse(for text: String) -> AnyPublisher<String, Error>
}


class OpenAIService: OpenAIServiceProtocol {
    private let openAIClient: OpenAI
    
    init(apiKey: String) {
        self.openAIClient = OpenAI(apiToken: apiKey)
    }
    
    
    func fetchResponse(for text: String) -> AnyPublisher<String, Error> {
        
        let chatQuery = ChatQuery(messages: [.init(role: .user, content: text)!], model: .gpt3_5Turbo)
        return Future { promise in
            self.openAIClient.chats(query: chatQuery) { result in
                switch result {
                case .success(let response):
                    if let responseText = response.choices.first?.message.content?.string {
                        promise(.success(responseText))
                    } else {
                        promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response text"])))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}
