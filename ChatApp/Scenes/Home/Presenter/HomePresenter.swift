//
//  HomePresenter.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//

import Foundation

protocol HomeView: AnyObject {
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func fetchNewRows(newAvailableIndexes: [Int])
    func showError(error: String)
    func addedFriendSuccesfully()

}

class HomePresenter {
    private weak var view: HomeView?
    var usersProvider : PaginationProvider<friend>!
    private let HomeNetworInstance: PaginationNetworkRequests = HomeNetworkRequestsImplementation()
    
    
    init(view: HomeView) {
        self.view = view
    }
    
    func viewDidLoad() {
        getUsers()
    }
    
    func getUsers(){
        usersProvider = PaginationProvider.init(marginBeforeLoadNextPage: 10, networkInstance: HomeNetworInstance, params:nil, queryString: nil, customHeaders: nil)
        usersProvider.delegate = self
        usersProvider.resetORbegin()
        view?.fetchingDataSuccess()
    }

    
    func getUsersCount() -> Int {
        
        return usersProvider.elements.count
    }
    
    func configure(cell: UserCellView, for index: Int) {
 
        if let fullname = usersProvider.elements[index].fullname {
            cell.displayUserName(name: fullname)
        }
        if let image = usersProvider.elements[index].img {
            cell.displayUserImage(Url: image)
        }
        cell.setBtnTitle(title : "Add Friend")
   
    }
    func willDisplayItemAt(for index: Int) {
        usersProvider.willDisplayItemAt(index: index)
    }
 
    func didSelectRow(for index: Int) {
        
        let friendId = usersProvider.elements[index].id ?? 0
        if friendId == LoginData.loadSavedLoginData()?.user?.id ?? 0 {
            view?.showError(error: "You Can't add yourself")
            return
        }
        SocketManger.shared.addNewFriend(friendId: friendId) {
            self.view?.addedFriendSuccesfully()
        }
    
    }
    
}


extension HomePresenter : PaginationDelegate  {
    
    
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

