//
//  Common.swift
//  NasaDemo
//
//  Created by Admin on 22/03/22.
//  Common constants/ functions

import Foundation

struct Constants {
    static let BaseURL = "https://api.nasa.gov/planetary/"
    static let APIKey = "7aQUfnPcTf2KosdnTnIiDwZb2AClZ8qf23MZA2Hv"
    static let ErrorText = "Error"
    static let OKText = "Ok"
    static let CancelAlertTitle = "Cancel"
    static let CalenderImage = "calender"
    static let NoImage = "no-image-icon"
    static let DateFormatForApod = "yyyy-MM-dd"
    static let MediaTypeImage = "image"
    static let MediaTypeVideo = "video"
    
    static let CachedResponseKey = "CachedResponse"
    enum MediaType {
        case image
        case video
    }
  
}
