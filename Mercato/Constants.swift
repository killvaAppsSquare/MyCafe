//
//  Constants.swift
//  Elmla3eb
//
//  Created by Macbook Pro on 3/12/17.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import UIKit



class Constants  {
    
    // #5a1e18   dark red
    // #b42024   light red
   static var USER_ID :Int = {
        guard  let userID = UserDefaults.standard.value(forKey: "userId") as? Int else {
            //        print("error fetching userId from NSUserD.userId")
            return 0
        }
        return userID
    }()
    static let screenSize: CGRect = UIScreen.main.bounds
    
    class API {
        //       private static let main_url = "http://appstest.xyz/api/"
        private static let main_url = "http://mercatocoffee.com/api/"
        
        
        class URLS {
            //            let API_TOKEN = "?api_token=776645543"
            //            let IMAGES_URL = "https://almala3b.com/"
            //           private  let HEADER_ID  = "X-Authorization-token"
            //           private  let HEADER_Value = "12b20fa6cca0ee113dc92d16f6be3029"
            
            let HEADER = ["X-Authorization-token" : "12b20fa6cca0ee113dc92d16f6be3029"]
            
            //ARTICLES
            //            let POST_ARTICLES_DATA = API.main_url + "articles"
            //            let GET_ARTICLES_ALL = API.main_url + "articles"
            //            let GET_ARTICLES_DATA_BY_ID = API.main_url + "articles/"
            //////////////
            //User
            let POST_REGISTER = API.main_url + "register"
            let POST_LOGIN = API.main_url + "login"
            
            let GET_OUR_MENU = API.main_url + "our_menu"
            let POST_RESET_PASSWORD = API.main_url + "password_reset"
            let GET_SEND_PASSWORD = API.main_url + "password_send"
            let GET_POINTS = API.main_url + "points"
            let GET_PRODUCTS = API.main_url + "products"
            let POST_PRODUCTS_CAT = API.main_url + "products_category"
            let POST_PROFILE = API.main_url + "profile"
            let GET_REVIEW = API.main_url + "reviews"
            let POST_ADD_REVIEW = API.main_url + "add_review"

        }
        
        class Parameters {
            
            
            let email = "email"
            let password = "password"
            let phone_number = "phone_number"
            let birthday = "birthday"
            let name = "name"
            let photo = "photo"
            let points = "points"
            let api_status = "api_status"
            let id = "id"
            let api_message = "api_message"
            //add_review
            let drinks = "drinks"
            let food = "food"
            let services = "services"
            let employees = "employees"
            let cleanness = "cleanness"
            let notes = "notes"
            let user_id = "user_id"
            let code = "code"
            //@End
        }
        
    }
    
    
    
    
    
    
    
    
    
}
