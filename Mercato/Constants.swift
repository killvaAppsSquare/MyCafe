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
    
    
    
    class Colors {
        static let blue = UIColor(colorLiteralRed: 57/255, green: 84/255, blue: 159/255, alpha: 1) //  #39599f
        
        static let green = UIColor(colorLiteralRed: 92/255, green: 173/255, blue: 40/255, alpha: 1)   //  #5cad28
        
        static let red = UIColor(colorLiteralRed: 177/255, green: 17/255, blue: 22/255, alpha: 1)    // #b11116
        
        static  let black = UIColor(colorLiteralRed: 40/255, green: 40/255, blue: 40/255, alpha: 1)    //   #282828
        static  let lightGray = UIColor(colorLiteralRed: 175/255, green: 175/255, blue: 175/255, alpha: 1)     //   #989898
        
        static  let gray = UIColor(colorLiteralRed: 152/255, green: 152/255, blue: 152/255, alpha: 1)     //   #989898
        
        static  let darkGreen = UIColor(colorLiteralRed: 74/255, green: 139/255, blue: 32/255, alpha: 1)     //   #4A8B20
        
        //    static  let yellow = UIColor(colorLiteralRed: 152/255, green: 152/255, blue: 152/255, alpha: 1)  //   #d8c800
    }
    
    

    
    
}
