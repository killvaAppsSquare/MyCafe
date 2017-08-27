//
//  M_User_Points.swift
//  Mercato
//
//  Created by Macbook Pro on 8/27/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class M_User_Points {
    
    
    //(completed : @escaping ([RepoVars]?) ->())
    private  let source = Constants.API.URLS()
    private   let parSource = Constants.API.Parameters()
    
    func getWalletData( completed : @escaping ([UserPoints_Vars]?,PostLoginVars?,Bool)->()) {
        
        let url = source.GET_WALLET + "?id=\(Constants.USER_ID)"
        //        print("URL: is postLoginData RL : \(url)")
        
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
//                print("that is  getWalletData getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                //                let  api_message = json[parm.api_message].stringValue
                let redeemed_cards = json[parm.redeemed_cards]
                var menus = [UserPoints_Vars]()
                for (_,json ) in redeemed_cards {
                    menus.append(UserPoints_Vars(json))
                }
                let profileData = PostLoginVars(json[parm.user_data])
                //                let data = json["data"]
                
                //                var profileData =  PostLoginVars(data)
                
                
                completed( menus,profileData, status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
      print("that is fail i n getting the getWalletData Mate : \(response.result.error?.localizedDescription)")
                
                completed(nil, nil , false)
                break
            }
        }
    }
    
    
    func getPointsRedeemList(completed : @escaping ([User_RedeemPoints_Var]?,Int?,Bool)->()) {
//        let parameters : Parameters = [ parSource.user_id  : Constants.USER_ID]
        //        print("that is the parameters in postLoginData : \(parameters)")
        
 
        let url = source.GET_POINTS + "?user_id=\(Constants.USER_ID)"

//         let url = source.GET_POINTS
                print("URL: is getPointsRedeemList RL : \(url)")
        
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
                //                print("that is  postUserData_LOGIN getting the data Mate : %@", response.result.value)
                let parm = Constants.API.Parameters()
                let status: Bool  =  json[parm.api_status].intValue == 0 ? false : true
                let redeemPointsData = json["data"]
                let points = json["user_points"].intValue
                var dataX =  [User_RedeemPoints_Var]()
                
                for ( _,json) in redeemPointsData {
                    dataX.append(User_RedeemPoints_Var(json))
                }
                completed(dataX ,points, status )
                break
                
            case .failure(_) :
                
                //                if let data = response.data {
                //                    let json = String(data: data, encoding: String.Encoding.utf8)
                //                    print("Failure Response: \(json)")
                //                }
                print("that is fail i n getting the Login data Mate : \(String(describing: response.result.error?.localizedDescription))")
                
                completed(nil,nil,false)
                break
            }
        }
    }     
    

    
}




class UserPoints_Vars {
    private   let source = Constants.API.Parameters()
    private   let imageURL = Constants.API.URLS()
    
    //[
    private var _id :Int?
    private var _point_id :Int?

    private var _value  : String?
    private var _qr_path  : String?
    private var _expire_date : String?
    
    //]
    
    //[
    var id : Int {
        guard let x = _id else { return 0 }
        return x
    }
    var point_id : Int {
        guard let x = _point_id else { return 0 }
        return x
    }
    var qr_path : String {
        guard let x = _qr_path else { return "" }
        return imageURL.IMAGE_URL +  x
    }
    
    var expire_date : String {
        guard let x = _expire_date else { return "" }
        return x
    }
    
    var value : String {
        guard let x = _value else { return "" }
        return x
    }

    
    
    init(_ jsonData : JSON) {
        self._qr_path = jsonData[source.qr_path].stringValue
        self._expire_date = jsonData[source.expire_date].stringValue
        self._value = jsonData[source.value].stringValue

        self._id = jsonData[source.id].intValue
        self._point_id = jsonData[source.point_id].intValue

     }
    
    
}




class User_RedeemPoints_Var {
    private   let source = Constants.API.Parameters()
    private   let imageURL = Constants.API.URLS()
    
    //[
    private var _id :Int?
    private var _points :Int?
    
    private var _value  : String?
    private var _description  : String?
    
    //]
    
    //[
    var id : Int {
        guard let x = _id else { return 0 }
        return x
    }
    var points : Int {
        guard let x = _points else { return 0 }
        return x
    }
    var description : String {
        guard let x = _description else { return "" }
        return   x
    }
    
 
    
    var value : String {
        guard let x = _value else { return "" }
        return x
    }
    
    
    
    init(_ jsonData : JSON) {
        self._description = jsonData[source.description].stringValue
        self._value = jsonData[source.value].stringValue
        
        self._id = jsonData[source.id].intValue
        self._points = jsonData[source.points].intValue
        
    }
    
    
}

