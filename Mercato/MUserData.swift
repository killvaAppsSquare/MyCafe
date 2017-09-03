//
//  PostLoginM.swift
//  Elmla3eb
//
//  Created by Macbook Pro on 3/28/17.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MUserData {
    
    
    //(completed : @escaping ([RepoVars]?) ->())
    private  let source = Constants.API.URLS()
    private   let parSource = Constants.API.Parameters()
    
    func postLoginData(email: String , userPassword:String ,completed : @escaping (PostLoginVars?,Bool)->()) {
        let parameters : Parameters = [ parSource.email : email , parSource.password : userPassword ]
//        print("that is the parameters in postLoginData : \(parameters)")
        
        
//        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
//        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        let url = source.POST_LOGIN
//        print("URL: is postLoginData RL : \(url)")
        
        Alamofire.request(url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
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
//                print("that is  postUserData_LOGIN getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let data = json["data"]
                
                var profileData =  PostLoginVars(data)
 
                
                completed(profileData , status )
                break
                
            case .failure(_) :
                
//                if let data = response.data {
//                    let json = String(data: data, encoding: String.Encoding.utf8)
//                    print("Failure Response: \(json)")
//                }
                print("that is fail i n getting the Login data Mate : \(response.result.error?.localizedDescription)")
 
                completed(nil,false)
                break
            }
        }
    }     
    
    
    func postRegiserationData(name : String?, phone_number : String?,email: String? ,userPassword:String? , birthday : String?  ,serialNum : String? ,completed : @escaping (Bool,Int?)->()) {
        let parameters : Parameters = [ parSource.email : email , parSource.password : userPassword, parSource.name : name, parSource.birthday : birthday, parSource.phone_number : phone_number,parSource.serial_number : serialNum]
        //        print("that is the parameters in postLoginData : \(parameters)")
        
        
        //        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        //        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        let url = source.POST_REGISTER
        //        print("URL: is postLoginData RL : \(url)")
        
        Alamofire.request(url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
                        print(response.result)
            switch(response.result) {
            case .success(_):
                guard response.result.error == nil, let value = response.result.value  else {
                    
                    // got an error in getting the data, need to handle it
                    //                    print("error fetching data from url")
                    print(response.result.error!)
                    return
                    
                }
                let json = JSON(value) // SwiftyJSON
//                print("that is  postRegiserationData getting the data Mate : %@", response.result.value!)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let id = json["id"].intValue
                print(status ,id )
                completed(status, id)
                break
                
            case .failure(_) :
                
//                if let data = response.data {
//                    let json = String(data: data, encoding: String.Encoding.utf8)
//                    print("Failure postRegiserationData Response: String(describing: \(js)on)")
//                }
                print("that is fail i n getting the postRegiserationData data Mate : \(String(describing: response.result.error?.localizedDescription))")
                
                completed(false ,nil )
                break
            }
        }
    }
    
    
    
    func getProfileData( completed : @escaping (PostLoginVars?,Bool)->()) {
        
        let url = source.GET_PROFILE + "?id=\(USER_ID)"
                print("URL: is postLoginData RL : \(url)")
        
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
                                print("that is  postUserData_LOGIN getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let data = json["data"]
                
                let profileData =  PostLoginVars(data)
                
                
                completed(profileData , status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
                print("that is fail i n getting the Login data Mate : \(String(describing: response.result.error?.localizedDescription))")
                
                completed(nil,false)
                break
            }
        }
    }
   
    
    func postProfileData(name: String? , email: String?,birthday:String? , phone_number:String? ,completed : @escaping (PostLoginVars?,Bool)->()) {
        let parameters : Parameters = [ parSource.id : USER_ID , parSource.name : name , parSource.email :email , parSource.birthday : birthday , parSource.phone_number : phone_number ]
        //        print("that is the parameters in postLoginData : \(parameters)")
        
        
        //        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        //        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        let url = source.POST_PROFILE
        //        print("URL: is postLoginData RL : \(url)")
        
        Alamofire.request(url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
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
                //                print("that is  postUserData_LOGIN getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let data = json["data"]
                
                var profileData = PostLoginVars(data)
                
                
                completed(profileData , status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
                print("that is fail i n getting the postProfileData  Mate : \(response.result.error?.localizedDescription)")
                
                completed(nil,false)
                break
            }
        }
    }
    
    
    
    func getQrScannerValue(serial_number : String ,completed : @escaping ( PostLoginVars?,Int?,Bool)->()) {
        
        let url = source.GET_QRScanner + "?serial_number=\(serial_number)"
                print("URL: is postLoginData RL : \(url)")
        
        Alamofire.request(url , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
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
                 let code = json[parm.code].int
               
                if code == 9000 {
                let data = json["user_data"]
                print(data)
                let profileData =  PostLoginVars(data)
                    completed( profileData,code, status )
                    return
                }
                //                let data = json["data"]
                
                //                var profileData =  PostLoginVars(data)
                
                
                completed( nil,code, status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
                print("that is fail i n getting the Login data Mate : \(response.result.error?.localizedDescription)")
                
                completed(nil,nil , false)
                break
            }
        }
    }

    
   }



class PostLoginVars {
    private   let source = Constants.API.Parameters()
    private   let imageURL = Constants.API.URLS()

    //[
     private var _id :Int?

    private var _birthday  : String?
    private var _email  : String?
    private var _name : String?
    private var _phone_number  : String?
    private var _photo : String?
    private var _points : Int?
    //]
    
    //[
    var birthday : String {
        guard let x = _birthday else { return "" }
        return x
    }
    // [:]
    var email : String {
        guard let x = _email else { return "" }
        return x
    }
    var name : String {
        guard let x = _name else { return "" }
        return x
    }
    var phone_number : String {
        guard let x = _phone_number else { return "" }
        return x
    }
    var photo : String {
        guard let x = _photo else { return "" }
        return x
    }
    var points : Int {
        guard let x = _points else { return 0 }
        return x
    }
    var id : Int {
        guard let x = _id else { return 0 }
        return x
    }
    


    init(_ jsonData : JSON) {
        self._name = jsonData[source.name].stringValue
        self._email = jsonData[source.email].stringValue
        self._birthday = jsonData[source.birthday].stringValue
        self._phone_number = jsonData[source.phone_number].stringValue
        self._photo = jsonData[source.photo].stringValue
        self._points = jsonData[source.points].intValue
        self._id = jsonData[source.id].intValue


    }
    
    
}
