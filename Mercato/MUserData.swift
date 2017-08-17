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
    
    func postLoginData(email: String , userPassword:String ,completed : @escaping ((PostLoginVars?,Bool,String,[String:Any]?,String))->()) {
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
                guard response.result.error == nil else {
                    
                    // got an error in getting the data, need to handle it
//                    print("error fetching data from url")
                    print(response.result.error!)
                    return
                    
                }
                let json = JSON( response.result.value!) // SwiftyJSON
                print("that is  postUserData_LOGIN getting the data Mate : %@", response.result.value!)
                
                
                break
                
            case .failure(_) :
                
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Failure Response: \(json)")
                }
                print("that is fail i n getting the Login data Mate : \(response.result.error?.localizedDescription)")
 
                completed((nil,false, "Network Time out",nil ,"Network Time out"))
                break
            }
        }
    }     
    
    
    func postRegiserationData(name : String?, phone_number : String?,email: String? ,userPassword:String? , birthday : String?   ,completed : @escaping (Bool,Int?)->()) {
        let parameters : Parameters = [ parSource.email : email , parSource.password : userPassword, parSource.name : name, parSource.birthday : birthday, parSource.phone_number : phone_number]
        //        print("that is the parameters in postLoginData : \(parameters)")
        
        
        //        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        //        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        let url = source.POST_REGISTER
        //        print("URL: is postLoginData RL : \(url)")
        
        Alamofire.request(url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: source.HEADER).responseJSON { (response:DataResponse<Any>) in
            //            print(response.result)
            switch(response.result) {
            case .success(_):
                guard response.result.error == nil else {
                    
                    // got an error in getting the data, need to handle it
                    //                    print("error fetching data from url")
                    print(response.result.error!)
                    return
                    
                }
                let json = JSON( response.result.value!) // SwiftyJSON
//                print("that is  postRegiserationData getting the data Mate : %@", response.result.value!)
                let status : Bool  = json["api_status"].intValue == 0 ?  false : true
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
    
    
    
    
    
    
   }



class PostLoginVars {
    private   let source = Constants.API.Parameters()
    private   let imageURL = Constants.API.URLS()

    //[
    private var _success : String?
    // [:]
    private var _data  : String?
    private var _id :Int?

    private var _name  : String?
    private var _mobile  : String?
    private var _city : String?
    private var _area  : String?
    private var _pg_type : String?
    private var _type  : String?
    private var _team :String?
    private var _points : Int?
    private var _birth_date  : String?
    private var _map_lon  : String?
    private var _map_lat  : String?
    private var _email : String?
    private var _password  : String?
    private var _remember_token : String?
    private var _api_token : String?
    private var _created_at : String?
    private var _updated_at  : String?
    private var _deleted_at  : String?
    private var _image  : String?

     private var _position  : String?
    private var _snap_chat  : String?
    private var _fbId : String?
    private  var _message  : String?
    //]
    
    //[
    var success : String {
        guard let x = _success else { return "" }
        return x
    }
    // [:]
    var data  : String {
        guard let x = _data else { return "" }
        return x
    }
   
    var snapChat : String {
         guard let x = _snap_chat , x != "" , x != " "  else { return "unknown" }
         return x
    }
    var fbIDToken : String {
        guard let x = _fbId , x != "" , x != " "  else { return "unknown" }
        return x
    }
    
    var isFbUser : Bool {
        guard let x = _fbId , x != "" , x != " "  else { return false }
//        print("that is teh fb value : \(x)")
        return true
        
    }
    //]
    
//    init(name : String?,mobile:String?, city:String?,area:String?,ph_type:String?, map_lon:Double?,map_lat:Double?,email:String?,password:String?,rememberToken:String?,apiToken:String?,createdAt:String?,updatedAt:String?,deletedAt:String?,success:Bool?,message:String?) {
//        
//        
//    }
    
//    convenience init(name:String?,email:String?,city:String?,type:String?) {
//        self.init(name : nil,mobile:nil, city:nil,area:nil,ph_type:nil, map_lon:nil,map_lat:nil,email:nil,password:nil,rememberToken:nil,apiToken:nil,createdAt:nil,updatedAt:nil,deletedAt:nil,success:nil,message:nil)
    init(jsonData : JSON) {
        self._name = jsonData[source.name].stringValue
        self._email = jsonData[source.email].stringValue
 

    }
    
    
}
