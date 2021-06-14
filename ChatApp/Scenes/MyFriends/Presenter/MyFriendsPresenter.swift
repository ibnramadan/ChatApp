//
//  MyFriendsPresenter.swift
//  ChatApp
//
//  Created by iMac on 13/06/2021.
//


import Foundation

protocol MyFriendsView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func fetchNewRows(newAvailableIndexes: [Int])
    func showError(error: String)
    func selectFriendSuccesfully(friend :friend)
    
}

protocol  UserCellView {
    func  displayUserName(name: String)
    func displayUserImage(Url: String)
    func setBtnTitle(title : String)
}


class MyFriendsPresenter {
    private weak var view: MyFriendsView?
    var usersProvider : PaginationProvider<GetMyFriendModel>!
    private let MyFriendsNetworInstance: PaginationNetworkRequests = MyFriendsRequestsImplementation()
    
    
    init(view: MyFriendsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getMyFriends()
    }
    
    func getMyFriends(){
        let query = "/\(LoginData.loadSavedLoginData()?.user?.id ?? 0)/friends"
        usersProvider = PaginationProvider.init(marginBeforeLoadNextPage: 10, networkInstance: MyFriendsNetworInstance, params:nil, queryString: query, customHeaders: nil)
        usersProvider.delegate = self
        usersProvider.resetORbegin()
        view?.fetchingDataSuccess()
    }
    
    
    func getUsersCount() -> Int {
        
        return usersProvider.elements.count
    }
    
    func configure(cell: UserCellView, for index: Int) {
        let myId = LoginData.loadSavedLoginData()?.user?.id
        let friendId = usersProvider.elements[index].friend?.id
        let user = usersProvider.elements[index].user
        let friend = usersProvider.elements[index].friend
        let object = (myId == friendId) ?  user : friend
        
        if let fullname = object?.fullname {
            cell.displayUserName(name: fullname)
        }
        if let image = object?.img {
            cell.displayUserImage(Url: image)
        }
        
        cell.setBtnTitle(title : "Start Chat")
    }
    
    
    func didSelectRow(for index: Int) {
        let myId = LoginData.loadSavedLoginData()?.user?.id
        let friendId = usersProvider.elements[index].friend?.id
        let user = usersProvider.elements[index].user
        let friend = usersProvider.elements[index].friend
        let object = (myId == friendId) ?  user : friend
        
        self.view?.selectFriendSuccesfully(friend : object!)
        
    }
    
}


extension MyFriendsPresenter : PaginationDelegate  {
    
    
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


