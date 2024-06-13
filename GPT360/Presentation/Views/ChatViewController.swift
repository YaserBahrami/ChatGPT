//
//  ChatViewController.swift
//  GPT360
//
//  Created by Yaser on 13.06.2024.
//

import UIKit
import SnapKit
import Combine


class ChatViewController: UIViewController {
    
    private var viewModel: ChatViewModel
    private var suggestionCollectionView: UICollectionView!
    private var chatTableView: UITableView!
    private var textField: UITextField!
    private var sendButton: UIButton!
    
    private let sampleQuestions = [
        "Tell me about 1453 in Turkish culture",
        "What's AI?",
        "Tell me a joke",
        "How's the weather",
        "Recommend a movie",
        "How to cook pasta?",
        "What is Swift programming language",
        "Define gravity",
        "Teach me greeting in Turkish language",
        "List me 5 places I must visit in Turkey"
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        
        textField.delegate = self
        // Keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let backgroundImage = UIImage(named: "Background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupNavigationBar()
        setupTableViewUI()
        setupNewMessageUI()
        setupCollectionViewUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Chat GPT"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let removeButton = UIBarButtonItem(image: UIImage(named: "icon_delete"), style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.rightBarButtonItem = removeButton
    }
    
    private func setupTableViewUI() {
        chatTableView = UITableView()
        chatTableView.backgroundColor = .clear
        chatTableView.register(MessageCell.self, forCellReuseIdentifier: "messageCell")
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.estimatedRowHeight = 80
        chatTableView.rowHeight = UITableView.automaticDimension
        view.addSubview(chatTableView)
        
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-200)
        }
    }
    
    private func setupNewMessageUI() {
        textField = UITextField()
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.height.equalTo(36)
        }
        
        sendButton = UIButton(type: .custom)
        sendButton.setImage(UIImage(named: "icon_send"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(textField)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private func setupCollectionViewUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        suggestionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        suggestionCollectionView.register(QuestionCell.self, forCellWithReuseIdentifier: "questionCell")
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.delegate = self
        suggestionCollectionView.backgroundColor = .clear
        view.addSubview(suggestionCollectionView)
        
        suggestionCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textField.snp.top).offset(-8)
            make.height.equalTo(100)
        }
    }
    
    private func bindViewModel() {
        viewModel.$messages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.chatTableView.reloadData()
                self?.scrollToBottom()
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.updateSendButtonState(isLoading: isLoading)
            }
            .store(in: &cancellables)
    }
    
    private func scrollToBottom() {
        guard viewModel.messages.count > 0 else { return }
        let indexPath = IndexPath(row: viewModel.messages.count - 1, section: 0)
        chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @objc private func sendButtonTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.sendMessage(text)
        viewModel.messages.append(Message(text: text, isUser: true))
        textField.text = ""
        chatTableView.reloadData()
        view.endEditing(true)
    }
    
    @objc private func deleteButtonTapped() {
        viewModel.messages.removeAll()
        chatTableView.reloadData()
    }
    
    private func updateSendButtonState(isLoading: Bool) {
        let image = isLoading ? UIImage(named: "icon_loading") : UIImage(named: "icon_send")
        sendButton.setImage(image, for: .normal)
        sendButton.isEnabled = !isLoading
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        UIView.animate(withDuration: 0.3) {
            self.textField.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
            self.sendButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)

        }
    }
        
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.textField.transform = .identity
            self.sendButton.transform = .identity

        }
    }
     
    
}

// MARK: - UITextFieldDelegate method to hide keyboard when return key is pressed

extension ChatViewController: UITextFieldDelegate {
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as! QuestionCell
        cell.configure(with: sampleQuestions[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let question = sampleQuestions[indexPath.item]
        textField.text = question
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width * 0.8 // 80% of the screen width
        let height = suggestionCollectionView.bounds.height // Full height of the collection view
        return CGSize(width: width, height: height)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        let message = viewModel.messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
}
