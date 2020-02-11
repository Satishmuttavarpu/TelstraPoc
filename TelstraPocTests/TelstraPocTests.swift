//
//  TelstraPocTests.swift
//  TelstraPocTests
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import XCTest
@testable import TelstraPoc

class TelstraPocTests: XCTestCase {
        
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testAPIPerformanceExample() throws{
        
            var request: URLRequest = URLRequest(url: URL(string: baseURL)!)
                   request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
                   request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                   request.httpMethod = "GET"
        let expectations = expectation(description: "GET")

                   // Request the data
                   let session: URLSession = URLSession.shared
                   let task = session.dataTask(with: request) { (data, response, error) in
                       if let httpResponse = response as? HTTPURLResponse {
                           let statusCode = httpResponse.statusCode
                           
                        //First Test Case for checking StatusCode sucess it continue only when pass
                           if (statusCode == 200) {
                               XCTAssertEqual(statusCode, 200, "status code was  200")
                           }
                           else{
                               XCTFail()
                           }
                       }
                       
                    //Second Test Case :- if error then its will fails
                       guard error == nil else {
                           XCTAssertNil(error)
                           print(error!)
                           return
                       }
                       
                    //Third Test Case :- if json is nil then it will fails
                       guard let json = data else {
                           XCTFail()
                           return
                       }
                       
                    
                    //Gettnig mock json from local file
                       let localjson = self.testLocalJSONMapping()
                       
                       if let json = self.convertToDictionary(text: String(decoding: json, as: UTF8.self)){
                           guard let tittle = json["title"] as? String else {
                               return
                           }
                           guard let expectedtittle = localjson!["title"] as? String else {
                               return
                           }
                        
                         //Fourth Test Case for checking Main title
                           XCTAssertEqual(tittle, expectedtittle)
                           
                           
                           guard let jsonArray = json["rows"] as? [[String: Any]] else {
                               return
                           }
                           
                           guard let localjsonArray = localjson!["rows"] as? [[String: Any]] else {
                               return
                           }
                           
                           let  json = jsonArray[0]
                           let  localjson = localjsonArray[0]
                           
                           let actualjsontittle = json["title"] as? String
                           let expectedjsonTitle = localjson["title"] as? String
                        
                        //Fifth Test Case for checking sub title
                           XCTAssertEqual(expectedjsonTitle, actualjsontittle)
                           
                           
                           let expectedDescription = localjson["description"] as? String
                           let actualDescription = json["description"] as? String
                        //Fifth Test Case for checking discribtion
                           XCTAssertEqual(expectedDescription, actualDescription)
                        
                        expectations.fulfill()
                       }
                       
                   }
                   task.resume()
    
        self.waitForExpectations(timeout: 20) { (error) in
                   if let error = error {
                       XCTFail("Error: \(error.localizedDescription)")
                   }
               }
    }
    
    
    func testLocalJSONMapping() -> [String: Any]?{
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "LocalDataForTest", withExtension: "json") else {
            XCTFail("Missing file: LocalDataForTest.json")
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            if let localjson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {
                print("response JSON = \(localjson)")
                return localjson
            }
            
        } catch let error {
            XCTFail("Expectation Failed with error: %@", file: error as! StaticString);
        }
        XCTFail("no data");
        return nil
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
