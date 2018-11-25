# rxcatalog
Example app displaying a list of catalogs using RxSwift

### Instalation

Dependencies in this project are provided via Cocoapods. Please install all dependecies with [Pods][1]

`
pod install
`

#### Domain


The `Domain` is basically what the App is about and what use cases contains, divided on Entities and abstract UseCases.

#### Networking

The `Networking` is a basic network layer implementing the connection with any API.

#### Application
It is the main of the `Application` is responsible for delivering information to the user and handling user input. It contains the Scenes which will implement our delivery Pattern or architecture design.

##### Scenes
It is the main presentation layer. It has been used an MVVM, because it is a pattern that fits with Reactive paradigm.


## Detail 

To enforce modularity, `Infrastructure`, `Networking` and `Application` are separate targets in the App, which allows us to take advantage of the `internal` access layer in Swift to prevent exposing of types that we don't want to expose.

#### Infrastructure

Entities are implemented as Swift value types, implementing the Codable protocol to parse directly from json decoder

UseCases are protocols which do a specific thing. In our case Comments and Posts use cases where:

- Comments Retrieve and Save (Save is not calling the Network because of its lack of implementation on Server)
- Posts just Retrieve data

#### Networking

The Networking is a network layer implementing the basic networking methods using RxSwift and RxAlamofire to provide data from selected API's.

GET, PUT, POST, DELETE

Abstracting this layer into a module, allows our main application not depending on Alamofire framework and let us change it without any breaking change on our core.


#### RXCatalog / Application

In the current project, `Application` is implemented with the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern and heavy use of [RxSwift](https://github.com/ReactiveX/RxSwift), which makes binding very easy.

We have decided to remove Reactive dependency from our ViewControllers, making it simpler and decoupled from Rx framework.

To accomplish this situation we have divided our application into 3 different layers.

##### Datasource

- This layer links our data provider layer (Networking) with our main application. Implements every useCase and manage our data for caching or persisting if needed. 

##### Scenes

- This is our presentation layer, using MVVM to bind data between our datasource and our views. It is composed by:

    * ViewController - To present data to the user and to listen to user interaction.
    * ViewModel - To implement our business presentation logic, providing data to scenes.
    * Navigator - To implement navigation among scenes

[1]###Pods
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire)


### Modularization

The corner stone of modularization is you can hide implementation detail under `internal` access layer. 

### TODO:

* add tests 

### Links
* [ViewModel](https://medium.com/@azamsharp/mvvm-in-ios-from-net-perspective-580eb7f4f129)
* [Clean Architecture - RXSwift](https://medium.com/@rezafarahani/clean-architecture-with-rxswift-salt-f79abe547e32)

