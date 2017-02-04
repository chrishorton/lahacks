//
//  Services.swift
//  BudgetPool
//
//  Created by Rohin Bhushan on 2/4/17.
//  Copyright © 2017 DreamTeam5Ever. All rights reserved.
//

import Foundation
import AWSDynamoDB
import AWSCore

struct Services {
	
	static func authenticate() {
		let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1_RssDtRSQX")
		let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
		AWSServiceManager.default().defaultServiceConfiguration = configuration
		
		let dynamoDB = AWSDynamoDB.default()
		let kinesisRecorder = AWSKinesisRecorder.default()
		
		let testData = "test-data".data(using: .utf8)
		kinesisRecorder?.saveRecord(testData, streamName: "test-stream-name").continueOnSuccessWith(block: { (task:AWSTask<AnyObject>) -> AWSTask<AnyObject>? in
			// Guaranteed to happen after saveRecord has executed and completed successfully.
			return kinesisRecorder?.submitAllRecords()
		}).continueWith(block: { (task:AWSTask<AnyObject>) -> Any? in
			if let error = task.error as? NSError {
				print("Error: \(error)")
				return nil
			}
			
			return nil
		})

	}
}
