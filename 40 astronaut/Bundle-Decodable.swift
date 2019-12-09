//
//  Bundle-Decodable.swift
//  40 astronaut
//
//  Created by GayaneA on 11/18/19.
//  Copyright © 2019 ayanemay. All rights reserved.
//

import Foundation

//the same extention, using generics, so it will decode anything that confroms to Codable, just before using it we must specify type - var a: [Astronaut] = Bundle.main.decode....



extension Bundle{

    func decode <T : Codable>(file: String) -> T{
        
        guard let url = Bundle.main.url(forResource: file, withExtension: nil)
            else {fatalError("Coud not find the file")}
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failure to get content of url")
        }
        
        let jdecoder = JSONDecoder()
        //json can decode dates, and into specific format,
        let datef = DateFormatter()
        datef.dateFormat = "y-MM-d"
        jdecoder.dateDecodingStrategy = .formatted(datef)
        
        guard let loaded = try? jdecoder.decode(T.self, from: data)else{
            fatalError("failure to decode json file")
        }
        
        return loaded
 
    }
}


/*
extension Bundle{
    //day 40
    func decode(file: String) -> [Astronout]{
        //paul just said self.url(
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else{
            fatalError("could not find file in bundle")
        }
        guard let data = try? Data(contentsOf: url) else{
            fatalError("could not load the content of url of file")
        }
        
        let jdecoder = JSONDecoder()
        guard let loadedArr = try? jdecoder.decode([Astronout].self, from: data) else {
            fatalError("could not decod data")
        }
        
        
      return loadedArr
    }
    
}
*/
