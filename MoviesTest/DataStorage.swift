//
//  DataStorage.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

struct Actor {
    var name = ""
    var professions = [String]()
    var fans = [Fan]()
    var movies = [Movie]()
    var biography = ""
    var image = ""
    var imageBig = ""
    var moviesCount = 0
    var moviesWatched = 0
    var rate:Float = 0
    
}

struct Movie {
    var title = ""
    var year = ""
    var image = UIImage()
}


struct Fan {
    var name = ""
    var image = UIImage()
}

class DataStorage {
    
    static let shared = DataStorage()
    
    var WilliamDafoe:Actor {
        var actor = Actor()
        actor.name = "Willem Dafoe"
        actor.professions = ["Actor", "Director"]
        actor.biography = "Willem Dafoe (born July 22, 1955) is an American film, stage, and voice actor, and a founding member of the experimental theatre company The Wooster Group."
        actor.image = "persons_item_2"
        actor.imageBig = "actor_big"
        actor.moviesCount = 298
        actor.moviesWatched = 178
        actor.rate = 7.3
        actor.fans = self.fans
        
        return actor
    }
    
    
    var fans:[Fan] {
        
        let fansCount = 20
        
        var result = [Fan]()
        
        for i in 1..<fansCount {
            
            let image = UIImage(named: "fans_\((i%5)+1)")!
            
            var fan = Fan()
            fan.name = "fan \(i)"
            fan.image = UIImage.roundedRectImageFromImage(image: image,
                                                          imageSize: image.size,
                                                          cornerRadius: image.size.width / 2)
                
            result.append(fan)
        }
        
        return result
    }
    
//
//    let movies:[Dictionary<String,String>] = [
//        [
//            "title": "Moonlight",
//            "year": "2017",
//            "image": "movies_item_1"
//        ],
//        [
//            "title": "Deadpool",
//            "year": "2017",
//            "image": "movies_item_2"
//        ],
//        [
//            "title": "Mozart in the Jungle",
//            "year": "2009",
//            "image": "movies_item_3"
//        ]
//    ]
    
    let actors:[Dictionary<String,String>] = [
        [
            "name": "Christine Grant",
            "image": "persons_item_1"
        ],
        [
            "name": "Christine Grant",
            "image": "persons_item_2"
        ],
        [
            "name": "Christine Grant",
            "image": "persons_item_3"
        ],
        [
            "name": "Christine Grant",
            "image": "persons_item_4"
        ],
    ]
    
    let actorMovies: [Dictionary<String,String>] = [
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_1"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_2"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_3"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_4"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_5"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_6"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_7"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_8"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_9"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_10"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_11"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_12"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_13"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_14"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_15"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_1"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_2"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_3"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_4"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_5"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_6"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_7"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_8"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_9"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_10"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_11"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_12"
        ],
        [
            "title": "La La Land",
            "year": "2007",
            "image": "actor_movies_13"
        ],
        [
            "title": "Deadpool",
            "year": "2007",
            "image": "actor_movies_14"
        ],
        [
            "title": "Mozart in the Jungle",
            "year": "2009",
            "image": "actor_movies_15"
        ]
    ]
    
    lazy var movies:[Movie] = {
        
        var arr = [Movie]()
        
        var size = UIScreen.isiPhone4or5() ? CGSize(width: 80, height: 120) : CGSize(width: 100, height: 150)
        
        for dict in self.actorMovies {
            
            let image = UIImage(named: dict["image"]!)!
            var movie = Movie()
            movie.title = dict["title"]!
            movie.year = dict["year"]!
            movie.image = UIImage.roundedRectImageFromImage(image: image,
                                                            imageSize: size,
                                                            cornerRadius: 5)

            arr.append(movie)
        }
        
        return arr
    }()
}
