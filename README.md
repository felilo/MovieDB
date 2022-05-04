# TechnicalTest #

Requisitos:

Tener instalado cocoapods https://cocoapods.org
En la raiz del proyecto, desde la terminal, ejecutar el comando:

```
$ pod install
$ Abrir el archivo TechnicalTest.xcworkspace
```

### Estructura del proyecto ###

A continuacion una descripcion general de la estructura del proyecto y como esta compuesto cada directorio: 

-   app: Este grupo contiene las clases principales de la app
    -   AppDelegate: es un protocolo que define métodos que son llamados por el objeto de UIA singleton UIA en respuesta a eventos importantes en la vida de una aplicación 
    -   scenceDelegate: 
    -   MainCoordinator: Coordinador de navegacion principal de la app
    -   ConfigApp: Clase que se encarga de obtener los datos globales de la app, por ejemplo la base_url del api, etc
-   shared: Este grupo contiene las clases, enumerados, extensiones, modelos de negocio, proovedores, etc. Que pueden ser accedidos por cualquier modulo o clase de la app.
    -   utils: 
        -   Coordinator: Definicion del protocolo para la navegación en la app
        -   Bindable: Clase encargada de ejecutar acciones reactivas
        -   DefaultCollectionCell: Es una clase generica de tipo UICollectionViewCell
    -   managers:
        -   ImageManager: Es una envoltura para el uso de libreria de terceros con el fin de ejecutar acciones/funciones relacionadas al manejo de imagenes
        -   ResquestManager: Es una envoltura para el uso de libreria de terceros con el fin de ejecutar acciones/funciones relacionadas al manejo de peticiones Http
    -   views: 
        -   CardCollection: Es un collectionView con direccion horizontal con celdas en forma de tarjetas construido a modo de componente el cual revice una lista de items,  esta confirmado por:
            -   CardCollectionView: Es una clase de tipo UICollectionView la cual es encargada de realizar toda la configuración 
            -   CardCollectionView+Extensions: Ejecuta e implementa todas las funciones y protocolos relacionadas a un collectionView
            -   CardViewCell: Es una clase de tipo UICollectionView la cual es encargada crear la vista y comunicar a esta con la colleccion

    -   extensions: 
        -   UIView+Helpers: Encargada de crear nuevas funcionalidades para la clase UIView
        -   CollectionView+Helpers: Encargada de crear nuevas funcionalidades para la clase CollectionView.
    -   providers: Provedores para obtener datos desde un repositorio
        -   movie provider:
            -   MovieProvider+Protocols: Contrato q deben implementar todos los servicio
            -   MovieProvider: Encargado de pedir obtener los datos de un servicio
            -   MovieApiService: Clase que se encarga de ejecutar peticiones HTTP a travez del ResquestManager y procesar los datos
        -   video provider:
            -   VideoProvider+Protocols: Contrato q deben implementar todos los servicio
            -   VideoProvider: Encargado de pedir obtener los datos de un servicio
            -   VideoApiService: Clase que se encarga de ejecutar peticiones HTTP a travez del ResquestManager y procesar los datos
    -   modelos: son clases encargadas de definir el modelo de negocio de la app:
        -   MovieModel: Clase q esta compuesta por propiedades y funciones los cuales se encargana de definir el modelo de negocio
        -   VideoModel: Clase q esta compuesta por propiedades y funciones los cuales se encargana de definir el modelo de negocio
-   modules: 
    -   home: 
        - HomeCoordinator: Encargado de definir y manejar toda la navegcion entre controladores o sub modulos
        -   sub modulos (list, detail):
            -   List: Es una lista de peliculas clasificadas por categoria 
                -   MediaListViewModel: Encargado de procesar la informacion necesaria para finalmente trasmilirla de forma reactiva al MediaListController. Esta clase puede comunicarse con MovieProvider, HomeCoordinator.
                -   MediaListController: Encargado de recibir los datos que llegan desde el MediaListViewModel y mostrarlos graficamente. Esta clase unicamente puede comunicarse con MediaListViewModel.
            -   Detail: Detalle de una pelicula
                -   EntertainmentMediaDetailViewModel: Encargado de procesar la informacion necesaria para finalmente trasmilirla de forma reactiva al EntertainmentMediaDetailController. Esta clase puede comunicarse con VideoProvider, HomeCoordinator.
                -   EntertainmentMediaDetailController: Encargado de recibir los datos que llegan desde el EntertainmentMediaDetailViewModel y mostrarlos graficamente. Esta clase unicamente puede comunicarse con EntertainmentMediaDetailViewModel.
            -   Video Player: Reproducir un video
                -   VideoPlayerViewModel: Encargado de procesar la informacion necesaria para obtener el tipo de video player finalmente trasmilirla de forma reactiva al VideoPlayerController. Esta clase puede comunicandose con HomeCoordinator.
                -   VideoPlayerController: Encargado de recibir los datos que llegan desde el VideoPlayerViewModel y mostrarlos graficamente. Esta clase unicamente puede comunicarse con VideoPlayerViewModel.
            
            


### Cambiar configuraciones globales del proyecto (opcional) ###

Para modificar los parametros globales del proyecto editar el archivo "Config.plist", ubicado en el directorio "MovieDB"


### Principio de responsabilidad unica? ###

Es una clase, objeto o microservicio que se debe encargar de realizar/cumplir una función en especifico.


### Que caracteristicas  tiene un buen buen codigo ###

La escritura debe ser clara, buena segregacion, cumplir con parametros de alineamientos (lint), las funciones deben tener pocas lineas de codigo y finalmente aplicar e implementar buenas practicas como los principios de SOLID, arquitecuras y patrones de diseño


