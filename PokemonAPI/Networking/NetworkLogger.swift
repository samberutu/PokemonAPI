//
//  NetworkLogger.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//
#if DEBUG

import Foundation

struct NetworkLogger {
    static func log(request: URLRequest) {
        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)

        let method = request.httpMethod ?? ""
        let path = components?.path ?? ""
        let query = components?.query ?? ""
        let host = components?.host ?? ""

        var requestLog = "\n---------- REQUEST ---------->\n"
        requestLog += urlString
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query)\n"
        requestLog += "Host: \(host)\n"
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody {
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body, not utf8 encoded"
            requestLog += "\n\(bodyString)\n"
        }

        requestLog += "\n------------------------->\n"
        print(requestLog)
    }

    static func log(data: Data, response: HTTPURLResponse) {
        let urlString = response.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog = "\n<---------- RESPONSE ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }

        responseLog += "HTTP \(response.statusCode) \(path)?\(query)\n"
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in response.allHeaderFields {
            responseLog += "\(key): \(value)\n"
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data)
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let jsonString = String(data: data, encoding: .utf8) ?? "Can't render json, not utf8 encoded"
            responseLog += "\n\(jsonString)\n"
        } catch {
            let bodyString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body, not utf8 encoded"
            responseLog += "\n\(bodyString)\n"
        }

        responseLog += "<------------------------\n"
        print(responseLog)
    }
}

#endif
