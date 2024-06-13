//
//  OpenAIRepository.swift
//  GPT360
//
//  Created by Yaser on 13.06.2024.
//

import Combine

protocol OpenAIRepository {
    func fetchResponse(for text: String) -> AnyPublisher<String, Error>
}


class OpenAIRepositoryImpl: OpenAIRepository {
    private let service: OpenAIServiceProtocol
    
    init(service: OpenAIServiceProtocol) {
        self.service = service
    }
    
    func fetchResponse(for text: String) -> AnyPublisher<String, Error> {
        return service.fetchResponse(for: text)
    }
}
