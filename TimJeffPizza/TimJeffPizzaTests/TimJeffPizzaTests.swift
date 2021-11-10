//
//  TimJeffPizzaTests.swift
//  TimJeffPizzaTests
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import XCTest
@testable import TimJeffPizza

class TimJeffPizzaTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidApiCallOfstatusCode200() throws {
        //given
        
        let urlsString = "\(Constants.baseURL)/c9c124b0899ae9adc254146783c0b764/raw"
        
        let url = URL(string: urlsString)!
        let promise = expectation(description: "Status Code: 200")
        
        //when
        let dataTask = sut.dataTask(with: url) {_, response, error in
        //then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status Code: \(statusCode)")
                }
            }
            
        }
        dataTask.resume()
        //3
        wait(for: [promise], timeout: 5)
    }
}
