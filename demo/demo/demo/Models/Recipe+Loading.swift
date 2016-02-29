/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

    Abstract:
    An extension on the Recipe struct to load recipe definitions from a plist file in the application bundle.
*/

import Foundation

extension Recipe {
    
    /// Loads the recipes specified in the `Cookbook.plist` file.
    static func loadRecipes() -> [Recipe] {
        let bundle = NSBundle.mainBundle()
        guard let cookbookURL = bundle.URLForResource("Cookbook", withExtension: "plist") else { fatalError("Unable to determine URL for cookbook plist.") }
        guard let fileContents = NSArray(contentsOfURL: cookbookURL) as? [[String: String]] else { fatalError("Unable to load cookbook plist.") }
        
        let recipies: [Recipe] = fileContents.flatMap { recipeData in
            // Fetch the recipe information.
            guard let title = recipeData["Title"],
                descriptionFileName = recipeData["Document"],
                identifierString = recipeData["Identifier"] else {
                    assertionFailure("Unable to fetch recipe information.")
                    return nil
            }
            
            // Convert the identifier string to an `Identifier` type.
            guard let identifier = StoryboardIdentifier(rawValue: identifierString) else {
                assertionFailure("Invalid recipe identifier: \(identifierString).")
                return nil
            }
            
            // Read the recipe description from the associated file.
            var description: String
            do {
                guard let descriptionURL = bundle.URLForResource(descriptionFileName, withExtension: nil) else {
                    fatalError("Unable to determine recipe description URL from fileName: \(descriptionFileName).")
                }
                
                try description = NSString(contentsOfURL: descriptionURL, encoding: NSUTF8StringEncoding) as String
            }
            catch {
                fatalError("Unable to read recipe description from file")
            }
            
            return Recipe(title: title, identifier: identifier, description: description)
        }
        
        return recipies
    }
}