//
//  DIContainer.swift
//  GPT360
//
//  Created by Yaser on 13.06.2024.
//

import Foundation


import Foundation

class DIContainer {
    static let shared = DIContainer()
    
    private var services: [String: Any] = [:]
    
    private init() {
        registerServices()
    }
    
    private func registerServices() {
        
        services[String(describing: OpenAIServiceProtocol.self)] = OpenAIService(apiKey: "Place your API Key here") as OpenAIServiceProtocol
        services[String(describing: OpenAIRepository.self)] = OpenAIRepositoryImpl(service: resolve()) as OpenAIRepository
        services[String(describing: ChatUseCase.self)] = ChatUseCaseImpl(repository: resolve()) as ChatUseCase
        services[String(describing: ChatViewModel.self)] = ChatViewModel(chatUseCase: resolve()) as ChatViewModel
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        guard let service = services[key] as? T else {
            fatalError("Unresolved type: \(T.self)")
        }
        return service
    }
}
