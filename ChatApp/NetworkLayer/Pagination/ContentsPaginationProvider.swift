//
//  ContentsPaginationProvider.swift
//  ChatApp
//
//  Created by iMac on 11/06/2021.
//


import Foundation
import ObjectMapper

class PaginationProvider<T: BaseMappable> : NSCopying {
    
    var elements: [T]
    
    var delegate: PaginationDelegate?
    private let networkInstance:PaginationNetworkRequests
    private let params: [String:Any]?
    private let queryString: String?
    private let customHeaders: [String:String]?
    
    private var lastPageResponse: ResponseArrayPaginatable<T>?
    private var indexOfLastItemDisplayed: Int = 0
    private var marginBeforeLoadNextPage: Int
    private var pagesLoadingInProgress = [Int]()
    
    init(marginBeforeLoadNextPage: Int,
         networkInstance: PaginationNetworkRequests,
         params: [String:Any]? = nil,
         queryString: String? = nil,
         customHeaders: [String:String]? = nil ) {
        elements = []
        self.marginBeforeLoadNextPage = marginBeforeLoadNextPage
        self.networkInstance = networkInstance
        self.params = params
        self.queryString = queryString
        self.customHeaders = customHeaders
    }
    
    func resetORbegin() {
        elements.removeAll()
        loadFirstPage()
    }
    
    func willDisplayItemAt(index: Int) {
        indexOfLastItemDisplayed = max(indexOfLastItemDisplayed, index)
        if shouldLoadNextPage() {
            loadNextPage()
        }
    }
    
    private func shouldLoadNextPage() -> Bool {
        guard indexOfLastItemDisplayed >= elements.count - 1 - marginBeforeLoadNextPage else { return false }
        guard lastPageResponse?.page  != lastPageResponse?.pageCount,
            let currentPage = lastPageResponse?.page,
            !pagesLoadingInProgress.contains(currentPage + 1) else { return false }
        return true
    }
    
    private func loadFirstPage() {
        delegate?.diplayLoadingForFirstPage()
        pagesLoadingInProgress = [0]
        self.getElements { [weak self] (response, error) in
            guard let self = self else { return }
            self.pagesLoadingInProgress.removeAll(where: { $0 == 0 })
            self.delegate?.hideLoadingForFirstPage()
            guard error == nil else { self.delegate?.diplayErrorForFirstPage(error: error!); return }
            self.lastPageResponse = response
            let firstIndex = self.elements.count
            self.elements.append(contentsOf: response?.data ?? [])
            print(response?.data ?? [])
            self.elements.reverse()
            let endIndex = self.elements.count
            self.delegate?.didEndLoadingContents(newAvailableIndexes: Array(firstIndex..<endIndex))
        }
    }
    
    private func loadNextPage() {
        delegate?.diplayLoadingForNextPage()
        let next = (lastPageResponse?.page ?? 0) + 1
        pagesLoadingInProgress.append(next)
        self.getElements { [weak self] (response, error) in
            guard let self = self else { return }
            self.pagesLoadingInProgress.removeAll(where: { $0 == next})
            self.delegate?.hideLoadingForNextPage()
            guard error == nil else { self.delegate?.diplayErrorForNextPage(error: error!); return }
            self.lastPageResponse = response
            let firstIndex = self.elements.count
            self.elements.append(contentsOf: response?.data ?? [])
            self.elements.reverse()
            let endIndex = self.elements.count
            self.delegate?.didEndLoadingContents(newAvailableIndexes: Array(firstIndex..<endIndex))
        }
    }
    
    private func getElements(completion: @escaping (ResponseArrayPaginatable<T>?, Error?) -> Void) {
        networkInstance.loadElements(type: T.self, specificURL: lastPageResponse?.links?.next , params: params, queryString: queryString, customHeaders: customHeaders) { (response) in
            switch response {
            case let .success(result) where result?.data != nil:
                completion(result, nil)
            case let .success(result):
                completion(nil, PaginationError(message: result?.message ?? "Server Error"))
            case let .failure(error) :
                completion(nil, PaginationError(message: "Server Error"))
                print(error.localizedDescription)
            }
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = PaginationProvider<T>(marginBeforeLoadNextPage: marginBeforeLoadNextPage, networkInstance: networkInstance, params: params, queryString: queryString, customHeaders: customHeaders)
        copy.elements = elements
        copy.delegate = delegate
        copy.lastPageResponse = lastPageResponse
        copy.indexOfLastItemDisplayed = indexOfLastItemDisplayed
        copy.marginBeforeLoadNextPage = marginBeforeLoadNextPage
        copy.pagesLoadingInProgress = pagesLoadingInProgress
        return copy
    }
    
}

protocol PaginationDelegate {
    func diplayLoadingForFirstPage()
    func diplayLoadingForNextPage()
    func hideLoadingForFirstPage()
    func hideLoadingForNextPage()
    func didEndLoadingContents(newAvailableIndexes: [Int])
    func diplayErrorForFirstPage(error: Error)
    func diplayErrorForNextPage(error: Error)
}

extension PaginationDelegate {
    func diplayLoadingForNextPage() {}
    func hideLoadingForNextPage() {}
    func diplayErrorForNextPage(error: Error) {}
}



