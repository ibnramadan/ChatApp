//
//  ServerResponce.swift
//  ChatApp
//
//  Created by iMac on 12/06/2021.
//

import Foundation

public enum ServerResponse: Int {
    case REQUEST_TIMEOUT = 408
    case OK = 200
    case UNKNOWN_ERROR = 666
    case PAYMENT_ERROR = 400
    case NOT_FOUND = 404
    case UPDATE_APP = 410
    case ACCOUNT_DISABLED = 411
    case ACCOUNT_BLOCKED = 412
    case ACCOUNT_OFFLINE = 413
    case COUPON_EXPIRED = 702
    case COUPON_ALREADY_USED = 703
    case COUPON_NOT_FOUND = 704
    case NO_CLOSE_FOUND = 303
    case HAS_PAYMENT_REQUEST = 901
    case NO_SUFFICIENT_AMOUNT = 902
    case NO_SUFFICIENT_CREDIT = 903
    case cancellation_fees = 220
    case fees_limit = 420
    case fees_limitTwo = 421
    case out_Of_Service = 415
    /**
     * The name of the enumeration (as written in case).
     */
    public var name: String {
        get { return String(describing: self) }
    }
    init(object:[Any]){
        if object[0] is String {
            self = ServerResponse.REQUEST_TIMEOUT
            return
        }
        self = ServerResponse(rawValue: object[0] as! Int) ?? ServerResponse.UNKNOWN_ERROR
    }
    /**
     * The full name of the enumeration
     * (the name of the enum plus dot plus the name as written in case).
     */
    public var errorMessage: String {
        get {
            switch self.rawValue {
            case 408 : return NSLocalizedString("error.backend.408", value: "Server didn't responded. this error could be due to connection problem or an inside problem in server.", comment: "")
            case 200 : return NSLocalizedString("error.backend.200", value: "Your request was done successfully.", comment: "")
            case 666 : return NSLocalizedString("error.backend.666", value: "Unknown Error", comment: "")
            case 400 : return NSLocalizedString("error.backend.400", value: "An error happened during payment.", comment: "")
            case 404 : return NSLocalizedString("error.backend.404", value: "No Driver found.", comment: "")
            case 410 : return NSLocalizedString("error.backend.410", value: "A mandatory update is found. please update.", comment: "")
            case 411 : return NSLocalizedString("error.backend.411", value: "Your account has been created but needs approval from dashboard.", comment: "")
            case 412 : return NSLocalizedString("error.backend.412", value: "Your account has been blocked by admin.", comment: "")
            case 413 : return NSLocalizedString("error.backend.413", value: "Driver is offline.", comment: "")
            case 303 : return NSLocalizedString("error.backend.303", value: "No close driver has been found.", comment: "")
            case 702 : return NSLocalizedString("error.backend.702", value: "Coupon is expired", comment: "")
            case 703 : return NSLocalizedString("error.backend.703", value: "Coupon is already used", comment: "")
            case 704 : return NSLocalizedString("error.backend.704", value: "Code not found", comment: "")
            case 901 : return NSLocalizedString("error.backend.901", value: "You have requested for payment already.", comment: "")
            case 902 : return NSLocalizedString("error.backend.902", value: "The amount is not sufficient to request a payment.", comment: "")
            case 903 : return NSLocalizedString("error.backend.903", value: "Credit is lower than expected. Please add credit to your wallet to continue using the app.", comment: "")
            case 220 : return NSLocalizedString("error.backend.220", value: "Previous fees There will be an extra payment from previous fees that should be paid at the end of the trip .Do you want to continue.", comment: "")
            case 420 : return NSLocalizedString("error.backend.420", value: "Can't order the service. you have fees that should be paid before ordering.", comment: "")
            case 421 : return NSLocalizedString("error.backend.420", value: "Can't order the service. you have fees that should be paid before ordering.", comment: "")
            case 415 : return NSLocalizedString("error.backend.415", value: "This area is out of service.", comment: "")
            default:
                return NSLocalizedString("error.backend.unknown", value: "Unknown Error", comment: "")
            }
            
        }
    }
    public var description: String {
        get { return String(reflecting: self) }
    }
}

