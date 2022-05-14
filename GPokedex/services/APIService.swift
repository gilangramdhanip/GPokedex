//
//  APIService.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import Foundation


class APIService {
    
    private var dataTask : URLSessionDataTask?
    private var url = "https://pokeapi.co/api/v2/"
    func fetchAllPokemon(offset: String, completion : @escaping (Result<PokemonModel, Error>) -> Void) {
        let moviesURL = "\(url)pokemon?offset=\(offset)&;amp;limit=20"
        let newUrl = moviesURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let url = URL(string: newUrl!) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(PokemonModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getDetailPokemon(link : String, completion : @escaping (Result<DetailPokemonModel, Error>) -> Void) {
        let detailURL = "\(link)"
        guard let url = URL(string: detailURL) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(DetailPokemonModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getColorPokemon(link : String, completion : @escaping (Result<PokemonColorModel, Error>) -> Void) {
        let detailURL = "\(link)"
        guard let url = URL(string: detailURL) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(PokemonColorModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
