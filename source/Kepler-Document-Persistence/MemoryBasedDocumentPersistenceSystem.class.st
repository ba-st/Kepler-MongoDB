Class {
	#name : #MemoryBasedDocumentPersistenceSystem,
	#superclass : #DocumentPersistenceSystem,
	#instVars : [
		'database'
	],
	#category : #'Kepler-Document-Persistence'
}

{ #category : #'system specification' }
MemoryBasedDocumentPersistenceSystem class >> implementedInterface [
	
	^ SystemInterface >> #DocumentPersistenceSystemInterface
]

{ #category : #adding }
MemoryBasedDocumentPersistenceSystem >> add: aDocument onCollectionNamed: aName [

	database
		at: aName
		ifPresent: [ :collection | collection add: aDocument ]
		ifAbsentPut: (OrderedCollection with: aDocument)
]

{ #category : #querying }
MemoryBasedDocumentPersistenceSystem >> collectionNamed: aName [

	^ database at: aName ifAbsent: [ #() ]
]

{ #category : #initialization }
MemoryBasedDocumentPersistenceSystem >> initialize [

	super initialize.
	database := Dictionary new.
]

{ #category : #querying }
MemoryBasedDocumentPersistenceSystem >> oneDocumentFilteredBy: aBlock onCollectionNamed: aCollectionName ifFound: aFoundBlock ifNone: aNoneBlock [

	| collection document |

	collection := database at: aCollectionName ifAbsentPut: [ OrderedCollection new ].
	document := collection detect: aBlock ifFound: [ :foundDocument | foundDocument ] ifNone: [ nil ].
	document ifNil: aNoneBlock ifNotNil: [ aFoundBlock value: document ]
]

{ #category : #'dependency resolution' }
MemoryBasedDocumentPersistenceSystem >> resolveDependecies [

	"do nothing"
]

{ #category : #updating }
MemoryBasedDocumentPersistenceSystem >> update: aDocumentToBeUpdated with: aDocument onCollectionNamed: aName [

	database
		at: aName
		ifPresent: [ :collection | collection remove: aDocumentToBeUpdated; add: aDocument ]
		ifAbsentPut: (OrderedCollection with: aDocument)
]
