Class {
	#name : #MongoDBBasedPersistenceSystem,
	#superclass : #DocumentPersistenceSystem,
	#instVars : [
		'database',
		'collections',
		'dbMutex'
	],
	#category : #'Kepler-Document-Persistence'
}

{ #category : #'system specification' }
MongoDBBasedPersistenceSystem class >> implementedInterface [
	
	^ SystemInterface >> #DocumentPersistenceSystemInterface
]

{ #category : #'instance creation' }
MongoDBBasedPersistenceSystem class >> using: aDatabase [

	^ self new initializeUsing: aDatabase
]

{ #category : #adding }
MongoDBBasedPersistenceSystem >> add: aDocument onCollectionNamed: aName [

	dbMutex critical: [ (self cachedCollection: aName) add: aDocument ]
]

{ #category : #private }
MongoDBBasedPersistenceSystem >> cachedCollection: aName [

	^ collections at: aName ifAbsentPut: [ MongoCollection database: database name: aName ]
]

{ #category : #querying }
MongoDBBasedPersistenceSystem >> collectionNamed: aName [

	^ dbMutex
		critical: [ (self cachedCollection: aName)
				query: [ :query | 
					query
						fields: {('_id' -> 0)} asDictionary;
						order: {('date' -> 1)} asDictionary;
						yourself ] ]
]

{ #category : #initialization }
MongoDBBasedPersistenceSystem >> initializeUsing: aDatabase [

	super initialize.
	database := aDatabase.
	collections := Dictionary new.
	dbMutex := Semaphore forMutualExclusion
]

{ #category : #querying }
MongoDBBasedPersistenceSystem >> oneDocumentFilteredBy: aBlock onCollectionNamed: aCollectionName ifFound: aFoundBlock ifNone: aNoneBlock [

	| document |

	document := dbMutex critical: [ (self cachedCollection: aCollectionName) detect: aBlock ].
	^ document ifNil: aNoneBlock ifNotNil: aFoundBlock
]

{ #category : #'dependency resolution' }
MongoDBBasedPersistenceSystem >> resolveDependecies [

	"do nothing"
]

{ #category : #'starting - stopping' }
MongoDBBasedPersistenceSystem >> shutDown [

	database root close
]

{ #category : #updating }
MongoDBBasedPersistenceSystem >> update: aDocumentToBeUpdated with: aDocument onCollectionNamed: aName [

	dbMutex critical: [ (self cachedCollection: aName) update: aDocumentToBeUpdated with: aDocument ]
]
