//
//  ChatPresenter.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//

import Foundation
import ObjectMapper
protocol ChatView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func messageSentSuccessfully()
    func fetchNewRows(newAvailableIndexes: [Int])
    func showError(error: String)

}

protocol  ChatSenderCellView {
    func displayMessageText(name: String)
    func displaydateLabel(name: String)
    func displayMsgStatusImage(status : Bool)
}
protocol  ChatRecieverCellView {
    func  displayMessageText(name: String)
    func displaydateLabel(name: String)
}

class ChatPresenter {
    private weak var view: ChatView?
    var ChatMessagesProvider : PaginationProvider<chatMessage>!
    private let ChatMessagesNetworInstance: PaginationNetworkRequests = ChatMessagesNetworkRequestsImplementation()
    
    
    init(view: ChatView) {
        self.view = view
        getNewMessages()
    }
    
    func getMessages(myId : Int , friendId: Int){
      
        let queryString = "?userId=\(myId)&friendId=\(friendId)"
        ChatMessagesProvider = PaginationProvider.init(marginBeforeLoadNextPage: 10, networkInstance: ChatMessagesNetworInstance, params:nil, queryString: queryString, customHeaders: nil)
        ChatMessagesProvider.delegate = self
        ChatMessagesProvider.resetORbegin()
        view?.fetchingDataSuccess()
    }
    func sendNewMessage(friendId : Int ,message : String){
        SocketManger.shared.sendNewMessage(friendId: friendId, content: message ) {

            view?.messageSentSuccessfully()
        }
    
    }
    
    func getMessagesCount() -> Int {
        
        return ChatMessagesProvider.elements.count
    }
    
    func configure(ChatSenderCell: ChatSenderCellView, ChatRecieverCell: ChatRecieverCellView,for index: Int) {
     
        let msg = ChatMessagesProvider.elements[index]
        print(msg)

        
        if msg.user?.id == LoginData.loadSavedLoginData()?.user?.id ?? 0 {

            if let Message = msg.content {
                ChatSenderCell.displayMessageText(name: Message)
            }
            if let date = msg.createdAt {
                ChatSenderCell.displaydateLabel(name: date)
            }
            if let seen = msg.seen {
                ChatSenderCell.displayMsgStatusImage(status : seen)
            }
        }
            
        else {
            if let Message = msg.content {
                ChatRecieverCell.displayMessageText(name: Message)
            }
            if let date = msg.createdAt {
                ChatRecieverCell.displaydateLabel(name: date)
            }

        }
   
    }
    
    func getNewMessages() {
     SocketManger.shared.getNewMessages()  { (newMsg) in
            if (newMsg != nil) {
                self.ChatMessagesProvider.elements.append(newMsg!)
                self.view?.fetchingDataSuccess()
            }
        }
    }
    
    func sendSeeMessage(friendId : Int){
        SocketManger.shared.seeMessage(friendId: friendId, completion: {
            
        })
    }
    
}


extension ChatPresenter : PaginationDelegate  {
    
    
    func diplayLoadingForFirstPage() {
        view?.showIndicator()
    }
    
    func hideLoadingForFirstPage() {
        view?.hideIndicator()
    }
    
    func didEndLoadingContents(newAvailableIndexes: [Int]) {
        view?.fetchNewRows(newAvailableIndexes:newAvailableIndexes)
   
    }
    
    func diplayErrorForFirstPage(error: Error) {
        view?.showError(error: error.localizedDescription)
    }
 
}



