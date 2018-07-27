Class {
	#name : #MongoDBBasedPersistenceSystem,
	#superclass : #DocumentPersistenceSystem,
	#instVars : [
		'database'
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

	| collection | 
	
	collection := database getCollection: aName.
	collection add: aDocument
]

{ #category : #querying }
MongoDBBasedPersistenceSystem >> collectionNamed: aName [

	^ (database getCollection: aName)
		query: [ :query | 
			query
				fields: {('_id' -> 0)} asDictionary;
				order: {('date' -> 1)} asDictionary;
				yourself ]
]

{ #category : #initialization }
MongoDBBasedPersistenceSystem >> initializeUsing: aDatabase [

	super initialize.
	database := aDatabase 
]

{ #category : #querying }
MongoDBBasedPersistenceSystem >> oneDocumentFilteredBy: aBlock onCollectionNamed: aCollectionName ifFound: aFoundBlock ifNone: aNoneBlock [

	| collection document |

	collection := database getCollection: aCollectionName.
	document := collection detect: aBlock.
	document ifNil: aNoneBlock ifNotNil: [ aFoundBlock value: document ]
]

{ #category : #'dependency resolution' }
MongoDBBasedPersistenceSystem >> resolveDependecies [

	"do nothing"
]

{ #category : #updating }
MongoDBBasedPersistenceSystem >> update: aDocumentToBeUpdated with: aDocument onCollectionNamed: aName [

	| collection | 
	
	collection := database getCollection: aName.
	collection update: aDocumentToBeUpdated with: aDocument
]
