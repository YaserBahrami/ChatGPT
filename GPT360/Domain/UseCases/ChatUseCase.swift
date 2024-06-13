//
//  ChatUseCase.swift
//  GPT360
//
//  Created by Yaser on 13.06.2024.
//

import Combine

protocol ChatUseCase {
    func fetchResponse(for text: String) -> AnyPublisher<String, Error>
}

class ChatUseCaseImpl: ChatUseCase {
    private let repository: OpenAIRepository
    
    init(repository: OpenAIRepository) {
        self.repository = repository
    }
    
    func fetchResponse(for text: String) -> AnyPublisher<String, Error> {
        return repository.fetchResponse(for: text)
    }
}
