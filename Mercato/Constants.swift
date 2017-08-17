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
           
        }
        
        class Parameters {
            
            
            let email = "email"
            let password = "password"
            let phone_number = "phone_number"
            let birthday = "birthday"
            let name = "name"
        }
        
    }
    
    
    
 
    
    

    
    
}
