//
//  GoogleBooksConstants.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/9/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation

extension GoogleBooksAPI {
    
    // MARK: - URL Contants
    struct GoogleBooksURL {
        static let APIScheme = "https"
        static let APIHost = "www.googleapis.com"
        static let APIPath = "/books/v1/volumes"
    }
    
    // MARK: - Google Books Parameter Keys
    struct GoogleBooksParameterKeys {
        static let Query = "q"
        static let APIKey = "key"
        static let Results = "maxResults"
    }
    
    // MARK: - Google Books Parameter Values
    struct GoogleBooksParameterValues {
        static let maxResults = "40"
    }
    
    // MARK: - Google Books Response Keys
    struct GoogleBooksResponseKeys {
        static let Items = "items"
        static let VolumeInfo = "volumeInfo"
        static let Title = "title"
        static let Subtitle = "subtitle"
        static let Authors = "authors"
        static let Publisher = "publisher"
        static let PublisedDate = "publishedDate"
        static let BookPages = "pageCount"
        static let SmallThumbnailURL = "smallThumbnail"
        static let PreviewURL = "previewLink"
        static let ImageLinks = "imageLinks"
        static let Language = "language"
        static let IndustryIDs = "industryIdentifiers"
        static let IndustryIDType = "type"
        static let Identifier = "identifier"
    }
    
    // MARK: - Google Books Response Values
    struct GoogleBooksResponseValues {
        static let ISBN13 = "ISBN_13"
        static let ISBN10 = "ISBN_10"
    }
    
}
