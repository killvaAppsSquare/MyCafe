//
//  MReviewData.swift
//  Mercato
//
//  Created by Macbook Pro on 8/22/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON


class MReviewData {
    
    
    //(completed : @escaping ([RepoVars]?) ->())
    private  let source = Constants.API.URLS()
    private   let parSource = Constants.API.Parameters()

    func postReview(parameters : [String:Any] ,completed : @escaping (_ reviewdOnce : Bool,Bool)->()) {
 
        let url = source.POST_ADD_REVIEW
        //        print("URL: is postLoginData RL : \(url)")
        
        Alamofire.request(url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
            //            print(response.result)
            switch(response.result) {
            case .success(_):
                guard response.result.error == nil, let value = response.result.value  else {
                    
                    // got an error in getting the data, need to handle it
                    //                    print("error fetching data from url")
                    print(response.result.error!)
                    return
                    
                }
                let json = JSON( value) // SwiftyJSON
                print("that is  postUserData_LOGIN getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let  api_message = json[parm.api_message].stringValue
                let code = json[parm.code].int
                let  reviewdOnce : Bool = code != 9000 ? true : false
               
 //                let data = json["data"]
                
//                var profileData =  PostLoginVars(data)
                
                
                completed( reviewdOnce, status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
                print("that is fail i n getting the Login data Mate : \(response.result.error?.localizedDescription)")
                
                completed(false  , false)
                break
            }
        }
    }
    
    
    
    
    func getTotalReviews(completed : @escaping (TotalReviews_Vars?,Int?,Bool)->()) {
        //        let parameters : Parameters = [ parSource.user_id  : Constants.USER_ID]
        //        print("that is the parameters in postLoginData : \(parameters)")
        
        
        let url = source.GET_REVIEW
        
        //         let url = source.GET_POINTS
        print("URL: is GET_REVIEW RL : \(url)")
        
        Alamofire.request(url , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
            //            print(response.result)
            switch(response.result) {
            case .success(_):
                guard response.result.error == nil, let value = response.result.value  else {
                    
                    // got an error in getting the data, need to handle it
                    //                    print("error fetching data from url")
                    //                    print(response.result.error!)
                    return
                    
                }
                let json = JSON( value ) // SwiftyJSON
                //                print("that is  GET_REVIEW getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let reviewsData = json["data"].arrayValue
                let code = json[parm.code].intValue
                
                
                guard  reviewsData[0] != JSON.null  else {
                    completed(nil ,nil, false )
                    return }
                let totalReviews_Vars = TotalReviews_Vars(reviewsData[0])
                print("thats total : \(totalReviews_Vars)")
//                for ( _,json) in reviewsData {
//
//                }
                completed(totalReviews_Vars ,code, status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
                print("that is fail i n getting the GET_REVIEW data Mate : \(String(describing: response.result.error?.localizedDescription))")
                
                completed(nil,nil,false)
                break
            }
        }
    }     
    
    
    
    
    
    
}


class TotalReviews_Vars {
    private   let source = Constants.API.Parameters()
    private   let imageURL = Constants.API.URLS()

    //[
    private var _total :Int?

    private var _services  : Int?
    private var _drinks  : Int?
    private var _food : Int?
    private var _employees  : Int?
    private var _cleanness : Int?
     //]

    //[
 
    var total : Int {
        guard let x = _total else { return 0 }
        return x
    }
    // [:]
    var services : Int {
        guard let x = _services else { return 0 }
        return x
    }
    var drinks : Int {
        guard let x = _drinks else { return 0 }
        return x
    }
    var food : Int {
        guard let x = _food else { return 0 }
        return x
    }
    var employees : Int {
        guard let x = _employees else { return 0 }
        return x
    }
    
    var cleanness : Int {
        guard let x = _cleanness else { return 0 }
        return x
    }


    init(_ jsonData : JSON) {
        self._cleanness = jsonData[source.cleanness].intValue
        self._services = jsonData[source.services].intValue
        self._drinks = jsonData[source.drinks].intValue
        self._food = jsonData[source.food].intValue
        self._employees = jsonData[source.employees].intValue
        self._total = jsonData[source.total].intValue


    }


}



//class PostLoginVars {
//    private   let source = Constants.API.Parameters()
//    private   let imageURL = Constants.API.URLS()
//    
//    //[
//    private var _id :Int?
//    
//    private var _birthday  : String?
//    private var _email  : String?
//    private var _name : String?
//    private var _phone_number  : String?
//    private var _photo : String?
//    private var _points : Int?
//    //]
//    
//    //[
//    var birthday : String {
//        guard let x = _birthday else { return "" }
//        return x
//    }
//    // [:]
//    var email : String {
//        guard let x = _email else { return "" }
//        return x
//    }
//    var name : String {
//        guard let x = _name else { return "" }
//        return x
//    }
//    var phone_number : String {
//        guard let x = _phone_number else { return "" }
//        return x
//    }
//    var photo : String {
//        guard let x = _photo else { return "" }
//        return x
//    }
//    var points : Int {
//        guard let x = _points else { return 0 }
//        return x
//    }
//    var id : Int {
//        guard let x = _id else { return 0 }
//        return x
//    }
//    
//    
//    
//    init(_ jsonData : JSON) {
//        self._name = jsonData[source.name].stringValue
//        self._email = jsonData[source.email].stringValue
//        self._birthday = jsonData[source.birthday].stringValue
//        self._phone_number = jsonData[source.phone_number].stringValue
//        self._photo = jsonData[source.photo].stringValue
//        self._points = jsonData[source.points].intValue
//        
//        
//    }
//    
//    
//}
