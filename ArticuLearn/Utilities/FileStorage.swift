//
//  FileStorage.swift
//  ArticuLearn
//
//  Created by azibai loc on 07/12/2023.
//

import Foundation

protocol FileFetcher {
    func fetchAllFiles(from folderUrl: URL) throws -> [URL]
    func fetchLatestFile(from folderUrl: URL) throws -> URL?
}

protocol FileSaver {
    func removeFile(with fileUrl: URL) throws
    func createFolder(with folderUrl: URL) throws
}

class FileStorage {
    static let `default` = FileStorage()
    
    private let documentsDirectoryURL: URL? = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private let recordStorageDirectoryURL: URL?
    
    init() {
        recordStorageDirectoryURL = documentsDirectoryURL?.appendingPathComponent(Constants.recordStorageDirectoryName)
        
        // Check if the folder exists, and create it if not
        if let directoryURL = recordStorageDirectoryURL {
            do {
                try createFolder(with: directoryURL)
            } catch {
                Log.log(type: .error, message: "Error creating folder: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: FileFetcher

extension FileStorage: FileFetcher {
    func fetchAllFiles(from folderUrl: URL) throws -> [URL] {
        return try FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    }
    
    func fetchLatestFile(from folderUrl: URL) throws -> URL? {
        let fileURLs = try fetchAllFiles(from: folderUrl)
        
        // Filter out directories and get the latest created file
        let filteredFiles = fileURLs.filter { (url) -> Bool in
            var isDirectory: ObjCBool = false
            FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
            return !isDirectory.boolValue
        }
        
        let latestFile = filteredFiles.max { (url1, url2) -> Bool in
            do {
                let attributes1 = try FileManager.default.attributesOfItem(atPath: url1.path)
                let attributes2 = try FileManager.default.attributesOfItem(atPath: url2.path)
                
                if let date1 = attributes1[.creationDate] as? Date,
                   let date2 = attributes2[.creationDate] as? Date {
                    return date1.compare(date2) == .orderedDescending
                }
            } catch {
                Log.log(type: .error, message: "Error comparing file attributes: \(error.localizedDescription)")
            }
            return false
        }
        
        return latestFile
    }
}

// MARK: FileSaver

extension FileStorage: FileSaver {
    func removeFile(with fileUrl: URL) throws {
        try FileManager.default.removeItem(at: fileUrl)
        Log.log(type: .info, message: "File removed successfully: \(fileUrl)")
    }
    
    func createFolder(with folderUrl: URL) throws {
        try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true, attributes: nil)
        Log.log(type: .info, message: "Folder created at: \(folderUrl.path)")
    }
}

// MARK: Constants

extension FileStorage {
    struct Constants {
        static let recordStorageDirectoryName: String = "records"
    }
}
